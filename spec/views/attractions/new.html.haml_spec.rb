require 'spec_helper'

describe "attractions/new" do
  before(:each) do
    assign(:attraction, stub_model(Attraction,
      :region_id => "",
      :gallery_id => "",
      :name => "MyString",
      :description => "MyText",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new attraction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", attractions_path, "post" do
      assert_select "input#attraction_region_id[name=?]", "attraction[region_id]"
      assert_select "input#attraction_gallery_id[name=?]", "attraction[gallery_id]"
      assert_select "input#attraction_name[name=?]", "attraction[name]"
      assert_select "textarea#attraction_description[name=?]", "attraction[description]"
      assert_select "input#attraction_slug[name=?]", "attraction[slug]"
    end
  end
end
