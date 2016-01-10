require 'rails_helper'

RSpec.describe "postings/edit", type: :view do
  before(:each) do
    @posting = assign(:posting, create(:posting))
  end

  it "renders the edit posting form" do
    render

    assert_select "form[action=?][method=?]", posting_path(@posting), "post" do
    end
  end
end
