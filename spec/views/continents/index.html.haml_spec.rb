require 'spec_helper'

describe "continents/index" do
  before(:each) do
    assign(:continents, [
      stub_model(Continent,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(Continent,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of continents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
