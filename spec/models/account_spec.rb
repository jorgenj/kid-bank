require 'rails_helper'

RSpec.describe Account, type: :model do
  let!(:cash_account) {
    create(:cash_account)
  }

  describe 'Account.without_earnigns' do
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
      expect(Account.cash_account).to be_a(Account)
      expect(Account.cash_account).to be_persisted
    end
  end

  describe 'user_accounts scope' do
    it 'should exclude cash_account' do
      user_acct1 = create(:account)
      user_acct2 = create(:account)

      expect(Account.cash_account).to be_persisted
      expect(Account.user_accounts).to match_array([user_acct1,user_acct2])
    end
  end
end
