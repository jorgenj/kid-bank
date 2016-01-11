require "rails_helper"

RSpec.describe TransactionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/accounts/2/transactions").to route_to("transactions#index", account_id: '2')
    end

    it "routes to #new" do
      expect(:get => "/accounts/2/transactions/new").to route_to("transactions#new", account_id: '2')
    end

    it "routes to #show" do
      expect(:get => "/accounts/2/transactions/1").to route_to("transactions#show", :id => "1", account_id: '2')
    end

    it "routes to #edit" do
      expect(:get => "/accounts/2/transactions/1/edit").to route_to("transactions#edit", :id => "1", account_id: '2')
    end

    it "routes to #create" do
      expect(:post => "/accounts/2/transactions").to route_to("transactions#create", account_id: '2')
    end

    it "routes to #update via PUT" do
      expect(:put => "/accounts/2/transactions/1").to route_to("transactions#update", :id => "1", account_id: '2')
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/accounts/2/transactions/1").to route_to("transactions#update", :id => "1", account_id: '2')
    end

    it "routes to #destroy" do
      expect(:delete => "/accounts/2/transactions/1").to route_to("transactions#destroy", :id => "1", account_id: '2')
    end
  end
end
