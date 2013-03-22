require 'spec_helper'

describe "regions/show" do
  before(:each) do
    @region = assign(:region, stub_model(Region,
      :country_id => 1,
      :galery_id => 2,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
