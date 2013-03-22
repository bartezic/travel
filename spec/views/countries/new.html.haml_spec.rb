require 'spec_helper'

describe "countries/new" do
  before(:each) do
    assign(:country, stub_model(Country,
      :continent_id => 1,
      :name => "MyString",
      :title => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new country form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", countries_path, "post" do
      assert_select "input#country_continent_id[name=?]", "country[continent_id]"
      assert_select "input#country_name[name=?]", "country[name]"
      assert_select "input#country_title[name=?]", "country[title]"
      assert_select "textarea#country_content[name=?]", "country[content]"
    end
  end
end
