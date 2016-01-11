require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  let(:user) {
    create(:user)
  }

  before {
    login_user user
  }
  
  let(:account) {
    create(:account, user: user)
  }

  describe "GET /accounts/:account_id/transactions" do
    it "works! (now write some real specs)" do
      get account_transactions_path(account)
      expect(response).to have_http_status(200)
    end
  end
end
