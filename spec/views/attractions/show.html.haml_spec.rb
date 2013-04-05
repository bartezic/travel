require 'spec_helper'

describe "attractions/show" do
  before(:each) do
    @attraction = assign(:attraction, stub_model(Attraction,
      :region_id => "",
      :gallery_id => "",
      :name => "Name",
      :description => "MyText",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Slug/)
  end
end
