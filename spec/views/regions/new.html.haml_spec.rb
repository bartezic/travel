require 'spec_helper'

describe "regions/new" do
  before(:each) do
    assign(:region, stub_model(Region,
      :country_id => 1,
      :galery_id => 1,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new region form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", regions_path, "post" do
      assert_select "input#region_country_id[name=?]", "region[country_id]"
      assert_select "input#region_galery_id[name=?]", "region[galery_id]"
      assert_select "input#region_name[name=?]", "region[name]"
      assert_select "textarea#region_description[name=?]", "region[description]"
    end
  end
end
