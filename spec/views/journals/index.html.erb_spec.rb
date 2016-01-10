require 'rails_helper'

RSpec.describe "journals/index", type: :view do
  before(:each) do
    assign(:journals, [
      create(:journal),
      create(:journal)
    ])
  end

  it "renders a list of journals" do
    render
  end
end
