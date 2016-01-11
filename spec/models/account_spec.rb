require 'rails_helper'

RSpec.describe Account, type: :model do
  let!(:cash_account) {
    create(:cash_account)
  }

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
