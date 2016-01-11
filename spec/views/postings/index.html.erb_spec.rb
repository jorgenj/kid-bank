require 'rails_helper'

RSpec.describe "postings/index", type: :view do
  before(:each) do
    @journal = assign(:journal, create(:journal))
    assign(:postings, [
      create(:posting, journal: @journal),
      create(:posting, journal: @journal)
    ])
  end

  it "renders a list of postings" do
    render
  end
end
