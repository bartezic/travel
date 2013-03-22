require "spec_helper"

describe HotelsController do
  describe "routing" do

    it "routes to #index" do
      get("/hotels").should route_to("hotels#index")
    end

    it "routes to #new" do
      get("/hotels/new").should route_to("hotels#new")
    end

    it "routes to #show" do
      get("/hotels/1").should route_to("hotels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hotels/1/edit").should route_to("hotels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hotels").should route_to("hotels#create")
    end

    it "routes to #update" do
      put("/hotels/1").should route_to("hotels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hotels/1").should route_to("hotels#destroy", :id => "1")
    end

  end
end
