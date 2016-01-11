require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      create(:account),
      create(:account)
    ])
  end

  it "renders a list of accounts" do
    render
  end
end
