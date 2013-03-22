require 'spec_helper'

describe "continents/new" do
  before(:each) do
    assign(:continent, stub_model(Continent,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new continent form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", continents_path, "post" do
      assert_select "input#continent_name[name=?]", "continent[name]"
      assert_select "textarea#continent_description[name=?]", "continent[description]"
    end
  end
end
