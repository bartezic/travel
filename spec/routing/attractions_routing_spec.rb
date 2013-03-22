require "spec_helper"

describe AttractionsController do
  describe "routing" do

    it "routes to #index" do
      get("/attractions").should route_to("attractions#index")
    end

    it "routes to #new" do
      get("/attractions/new").should route_to("attractions#new")
    end

    it "routes to #show" do
      get("/attractions/1").should route_to("attractions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/attractions/1/edit").should route_to("attractions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/attractions").should route_to("attractions#create")
    end

    it "routes to #update" do
      put("/attractions/1").should route_to("attractions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/attractions/1").should route_to("attractions#destroy", :id => "1")
    end

  end
end
