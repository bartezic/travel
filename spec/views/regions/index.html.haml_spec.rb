require 'spec_helper'

describe "regions/index" do
  before(:each) do
    assign(:regions, [
      stub_model(Region,
        :country_id => 1,
        :galery_id => 2,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(Region,
        :country_id => 1,
        :galery_id => 2,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of regions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
