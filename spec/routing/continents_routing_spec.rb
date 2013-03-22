require "spec_helper"

describe ContinentsController do
  describe "routing" do

    it "routes to #index" do
      get("/continents").should route_to("continents#index")
    end

    it "routes to #new" do
      get("/continents/new").should route_to("continents#new")
    end

    it "routes to #show" do
      get("/continents/1").should route_to("continents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/continents/1/edit").should route_to("continents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/continents").should route_to("continents#create")
    end

    it "routes to #update" do
      put("/continents/1").should route_to("continents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/continents/1").should route_to("continents#destroy", :id => "1")
    end

  end
end
