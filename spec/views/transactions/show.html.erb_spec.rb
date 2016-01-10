require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    @transaction = assign(:transaction, create(:transaction))
  end

  it "renders attributes in <p>" do
    render
  end
end
