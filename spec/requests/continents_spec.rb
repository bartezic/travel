require 'spec_helper'

describe "Continents" do
  describe "GET /continents" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get continents_path
      response.status.should be(200)
    end
  end
end
