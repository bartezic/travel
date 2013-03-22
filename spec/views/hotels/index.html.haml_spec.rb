require 'spec_helper'

describe "hotels/index" do
  before(:each) do
    assign(:hotels, [
      stub_model(Hotel,
        :region_id => "",
        :galery_id => "",
        :name => "Name",
        :description => "Description",
        :slug => "Slug"
      ),
      stub_model(Hotel,
        :region_id => "",
        :galery_id => "",
        :name => "Name",
        :description => "Description",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of hotels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
