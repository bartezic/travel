require "spec_helper"

describe ToursController do
  describe "routing" do

    it "routes to #index" do
      get("/tours").should route_to("tours#index")
    end

    it "routes to #new" do
      get("/tours/new").should route_to("tours#new")
    end

    it "routes to #show" do
      get("/tours/1").should route_to("tours#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tours/1/edit").should route_to("tours#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tours").should route_to("tours#create")
    end

    it "routes to #update" do
      put("/tours/1").should route_to("tours#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tours/1").should route_to("tours#destroy", :id => "1")
    end

  end
end
