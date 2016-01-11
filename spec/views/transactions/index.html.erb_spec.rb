require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    @account = assign(:account, create(:account))
    assign(:transactions, [
      create(:transaction, account: @account),
      create(:transaction, account: @account)
    ])
  end

  it "renders a list of transactions" do
    render
  end
end
