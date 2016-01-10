require 'rails_helper'

RSpec.describe "postings/index", type: :view do
  before(:each) do
    assign(:postings, [
      Posting.create!(),
      Posting.create!()
    ])
  end

  it "renders a list of postings" do
    render
  end
end
