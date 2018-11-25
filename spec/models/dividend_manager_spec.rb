require 'rails_helper'

RSpec.describe DividendManager, type: :model do
  let(:account) {
    create(:account, annual_percentage_rate: '4').tap do |acct|
      create(:deposit, account: acct, amount: 100_00)
    end
  }

  describe 'add_missing_earnings' do
    it 'should add interest accruals' do
      date = 2.days.ago
      expect(date).to be < Date.today

      expect(account.interest_accruals).to be_empty
      expect(Account.user_accounts).to match_array([account])
      expect(Account.user_accounts.without_earnings(date)).to match_array([account])

      ## add missing interest accrual
      expect {
        DividendManager.add_missing_accruals(date)
      }.to change { 
        InterestAccrual.count 
      }.by(1)

      expect(Account.user_accounts.without_earnings(date)).to be_empty

      ## doesn't get added again
      expect {
        DividendManager.add_missing_accruals(date)
      }.to_not change { 
        InterestAccrual.count 
      }

      accrual = InterestAccrual.last
      expect(accrual.account).to eq(account)
      expect(accrual.accrued_on).to eq(date.to_date)
      expect(accrual.account_end_balance).to eq(100_00)
      expect(accrual.amount).to eq(1)
      expect(accrual.applied).to be_falsey
      expect(accrual.applied_at).to be_nil
    end
  end

  describe 'the math' do
    it 'should be corrects' do
      expect(account.postings.sum(:amount)).to eq(100_00)
      expect(account.dpy).to be_within(0.00000001).of(0.00010958904109589)

      jan1 = Date.parse('2015-01-01')
      dec31 = Date.parse('2015-12-31')

      Range.new(jan1, dec31).each do |date|
        DividendManager.add_missing_accruals(date)
        DividendManager.apply_earnings(date)
      end

      account.reload
      expect(account.postings.sum(:amount)).to eq(103_61)
      expect(account.balance).to eq(103_61)
    end
  end

  describe 'apply_earnings' do
    let(:sunday) {
      date = 2.days.ago
      until date.sunday?
        date = date - 1.day
      end
      date
    }

    it 'should work' do
      expect(sunday).to be_sunday
      expect(sunday).to be < Date.today

      expect(account.interest_accruals).to be_empty
      expect(Account.user_accounts).to match_array([account])

      (0..9).each do |i|
        date = sunday - i.days
        expect(Account.user_accounts.without_earnings(date)).to match_array([account])
        DividendManager.add_missing_accruals(date)
      end

      account.reload
      expect(account.interest_accruals.count).to eq(10)

      expect {
        DividendManager.apply_earnings(sunday)
      }.to change {
        InterestAccrual.where(applied: false).count
      }.from(10).to(3)

      account.reload
      expect(account.balance).to eq(10007)

      posting = account.postings.last
      expect(posting.amount).to eq(7)
      expect(posting.journal.notes).to eq("Interest accrued - #{sunday.to_date}")
      other_posting = posting.journal.postings.to_a - [posting]
      expect(other_posting.map(&:account)).to match_array([Account.interest_account!])
    end
  end
end
