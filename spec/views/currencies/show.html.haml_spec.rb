require 'spec_helper'

describe "currencies/show" do
  before(:each) do
    @currency = assign(:currency, stub_model(Currency,
      :code => "Code",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Code/)
    rendered.should match(/Description/)
  end
end
