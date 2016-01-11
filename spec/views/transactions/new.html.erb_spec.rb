require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    @account = assign(:account, create(:account))
    @transaction = assign(:transaction, @account.transactions.new())
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", account_transactions_path(@account), "post" do
    end
  end
end
