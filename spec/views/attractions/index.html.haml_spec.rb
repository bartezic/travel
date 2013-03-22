require 'spec_helper'

describe "attractions/index" do
  before(:each) do
    assign(:attractions, [
      stub_model(Attraction,
        :region_id => "",
        :galery_id => "",
        :name => "Name",
        :description => "MyText",
        :slug => "Slug"
      ),
      stub_model(Attraction,
        :region_id => "",
        :galery_id => "",
        :name => "Name",
        :description => "MyText",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of attractions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
