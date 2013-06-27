require "spec_helper"

describe RequestActionsController do
  describe "routing" do

    it "routes to #index" do
      get("/request_actions").should route_to("request_actions#index")
    end

    it "routes to #new" do
      get("/request_actions/new").should route_to("request_actions#new")
    end

    it "routes to #show" do
      get("/request_actions/1").should route_to("request_actions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/request_actions/1/edit").should route_to("request_actions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/request_actions").should route_to("request_actions#create")
    end

    it "routes to #update" do
      put("/request_actions/1").should route_to("request_actions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/request_actions/1").should route_to("request_actions#destroy", :id => "1")
    end

  end
end
