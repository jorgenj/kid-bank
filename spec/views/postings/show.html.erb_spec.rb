require 'rails_helper'

RSpec.describe "postings/show", type: :view do
  before(:each) do
    @posting = assign(:posting, Posting.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
