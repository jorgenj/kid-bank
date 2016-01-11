require "rails_helper"

RSpec.describe PostingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/journals/:journal_id/postings").to route_to("postings#index", journal_id: ':journal_id')
    end

    it "routes to #new" do
      expect(:get => "/journals/:journal_id/postings/new").to route_to("postings#new", journal_id: ':journal_id')
    end

    it "routes to #show" do
      expect(:get => "/journals/:journal_id/postings/1").to route_to("postings#show", :id => "1", journal_id: ':journal_id')
    end

    it "routes to #edit" do
      expect(:get => "/journals/:journal_id/postings/1/edit").to route_to("postings#edit", :id => "1", journal_id: ':journal_id')
    end

    it "routes to #create" do
      expect(:post => "/journals/:journal_id/postings").to route_to("postings#create", journal_id: ':journal_id')
    end

    it "routes to #update via PUT" do
      expect(:put => "/journals/:journal_id/postings/1").to route_to("postings#update", :id => "1", journal_id: ':journal_id')
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/journals/:journal_id/postings/1").to route_to("postings#update", :id => "1", journal_id: ':journal_id')
    end

    it "routes to #destroy" do
      expect(:delete => "/journals/:journal_id/postings/1").to route_to("postings#destroy", :id => "1", journal_id: ':journal_id')
    end
  end
end
