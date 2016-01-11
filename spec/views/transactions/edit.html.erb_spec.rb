require 'rails_helper'

RSpec.describe "transactions/edit", type: :view do
  before(:each) do
    @account = assign(:account, create(:account))
    @transaction = assign(:transaction, create(:transaction, account: @account))
  end

  it "renders the edit transaction form" do
    render

    assert_select "form[action=?][method=?]", account_transaction_path(@account,@transaction), "post" do
    end
  end
end
