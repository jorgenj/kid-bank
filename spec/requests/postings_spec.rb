require 'rails_helper'

RSpec.describe "Postings", type: :request do
  before {
    login_user
  }
  let(:journal) {
    create(:journal)
  }

  describe "GET /journals/:journal_id/postings" do
    it "works! (now write some real specs)" do
      get journal_postings_path(journal)
      expect(response).to have_http_status(200)
    end
  end
end
