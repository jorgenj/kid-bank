require 'rails_helper'

RSpec.describe "postings/new", type: :view do
  before(:each) do
    @journal = assign(:journal, create(:journal))
    assign(:posting, Posting.new())
  end

  it "renders new posting form" do
    render

    assert_select "form[action=?][method=?]", journal_postings_path(@journal), "post" do
    end
  end
end
