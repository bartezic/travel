require 'spec_helper'

describe "regions/edit" do
  before(:each) do
    @region = assign(:region, stub_model(Region,
      :country_id => 1,
      :galery_id => 1,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit region form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", region_path(@region), "post" do
      assert_select "input#region_country_id[name=?]", "region[country_id]"
      assert_select "input#region_galery_id[name=?]", "region[galery_id]"
      assert_select "input#region_name[name=?]", "region[name]"
      assert_select "textarea#region_description[name=?]", "region[description]"
    end
  end
end
