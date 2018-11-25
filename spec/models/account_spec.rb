require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'Account.without_earnings' do
    let(:account) { create(:account) }

    it 'should return account with no interest accrual for date' do
      expect(account.interest_accruals).to be_empty
      expect(Account.user_accounts.without_earnings(Date.today)).to match_array([account])
    end

    it 'should not return account with interest accrual for date' do
      date = Date.today
      create(:interest_accrual, account: account, accrued_on: date, applied: false)
      expect(account.interest_accruals).to_not be_empty
      expect(Account.user_accounts.without_earnings(date)).to be_empty
    end
  end

  describe 'Account.cash_account' do
    it 'should be findable' do
      expect(Account.cash_account!).to be_a(Account)
      expect(Account.cash_account!).to be_persisted
    end
  end

  describe 'user_accounts scope' do
    it 'should exclude cash_account' do
      user_acct1 = create(:account)
      user_acct2 = create(:account)

      expect(Account.cash_account!).to be_persisted
      expect(Account.all.count).to eq(2 + SystemAccount.count)
      expect(Account.user_accounts).to match_array([user_acct1,user_acct2])
    end
  end

  describe 'interest_earned' do
    it 'should be correct' do
      # A sum of Rs 5000 is borrowed and the rate is 8%. What is the daily compound interest for 2 years?
      acct = create(:account, annual_percentage_rate: 8.0)
      Journal.deposit!(acct, 5_000_00)
      acct.reload

      # Interest = Principal * (1+(Rate/(100*365)))^(365∗Time) - Principal 
      # Interest = 5000 * (1+(8/(100∗365)))^(2∗365) - 5000 
      # Interest = 5000 * 1.173 - 5000 
      # Interest = 867.45

      expect(acct.balance).to eq(5_000_00)
      expect(acct.annual_percentage_rate).to eq(8.0)
      expect(acct.daily_percentage_rate).to be_within(0.00000001).of(8.0 / 365)
      expect(acct.dpy).to be_within(0.0000001).of(8.0 / (100 * 365))

      expect(acct.interest_earned(2.years)).to eq(86745)
    end
  end
end
