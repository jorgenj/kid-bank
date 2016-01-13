require 'rails_helper'

RSpec.describe DividendManager, type: :model do
  let(:account) {
    create(:account, daily_percentage_rate: '0.01', balance: 100).tap do |acct|
      create(:deposit, account: acct, amount: 100)
    end
  }

  describe 'add_missing_earnings' do
    it 'should add interest accruals' do
      date = Date.yesterday

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
      expect(accrual.accrued_on).to eq(date)
      expect(accrual.account_end_balance).to eq(100)
      expect(accrual.amount).to eq(1.0)
      expect(accrual.applied).to be_falsey
      expect(accrual.applied_at).to be_nil
    end
  end

  describe 'apply_earnings' do
    let(:sunday) {
      date = Date.yesterday
      until date.sunday?
        date = date - 1.day
      end
      date
    }

    it 'should work' do
      expect(sunday).to be_sunday

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
      expect(account.balance).to eq(107)

      posting = account.postings.last
      expect(posting.amount).to eq(7)
      other_posting = posting.journal.postings.to_a - [posting]
      expect(other_posting.map(&:account)).to match_array([Account.interest_account])
    end
  end
end
