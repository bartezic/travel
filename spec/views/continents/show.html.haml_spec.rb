require 'spec_helper'

describe "continents/show" do
  before(:each) do
    @continent = assign(:continent, stub_model(Continent,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
