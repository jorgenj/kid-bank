require 'rails_helper'

RSpec.describe "journals/show", type: :view do
  before(:each) do
    @journal = assign(:journal, create(:journal))
  end

  it "renders attributes in <p>" do
    render
  end
end
