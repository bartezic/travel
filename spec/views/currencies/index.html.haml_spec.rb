require 'spec_helper'

describe "currencies/index" do
  before(:each) do
    assign(:currencies, [
      stub_model(Currency,
        :code => "Code",
        :description => "Description"
      ),
      stub_model(Currency,
        :code => "Code",
        :description => "Description"
      )
    ])
  end

  it "renders a list of currencies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
