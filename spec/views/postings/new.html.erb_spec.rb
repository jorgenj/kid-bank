require 'rails_helper'

RSpec.describe "postings/new", type: :view do
  before(:each) do
    assign(:posting, Posting.new())
  end

  it "renders new posting form" do
    render

    assert_select "form[action=?][method=?]", postings_path, "post" do
    end
  end
end
