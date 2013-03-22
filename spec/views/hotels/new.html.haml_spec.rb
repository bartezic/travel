require 'spec_helper'

describe "hotels/new" do
  before(:each) do
    assign(:hotel, stub_model(Hotel,
      :region_id => "",
      :galery_id => "",
      :name => "MyString",
      :description => "MyString",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new hotel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hotels_path, "post" do
      assert_select "input#hotel_region_id[name=?]", "hotel[region_id]"
      assert_select "input#hotel_galery_id[name=?]", "hotel[galery_id]"
      assert_select "input#hotel_name[name=?]", "hotel[name]"
      assert_select "input#hotel_description[name=?]", "hotel[description]"
      assert_select "input#hotel_slug[name=?]", "hotel[slug]"
    end
  end
end
