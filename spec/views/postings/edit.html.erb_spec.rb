require 'rails_helper'

RSpec.describe "postings/edit", type: :view do
  before(:each) do
    @journal = assign(:journal, create(:journal))
    @posting = assign(:posting, create(:posting, journal: @journal))
  end

  it "renders the edit posting form" do
    render

    assert_select "form[action=?][method=?]", journal_posting_path(@journal,@posting), "post" do
    end
  end
end
