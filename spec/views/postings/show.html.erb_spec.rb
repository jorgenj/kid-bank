require 'rails_helper'

RSpec.describe "postings/show", type: :view do
  before(:each) do
    @journal = assign(:journal, create(:journal))
    @posting = assign(:posting, create(:posting, journal: @journal))
  end

  it "renders attributes in <p>" do
    render
  end
end
