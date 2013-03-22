require 'spec_helper'

describe "attractions/edit" do
  before(:each) do
    @attraction = assign(:attraction, stub_model(Attraction,
      :region_id => "",
      :galery_id => "",
      :name => "MyString",
      :description => "MyText",
      :slug => "MyString"
    ))
  end

  it "renders the edit attraction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", attraction_path(@attraction), "post" do
      assert_select "input#attraction_region_id[name=?]", "attraction[region_id]"
      assert_select "input#attraction_galery_id[name=?]", "attraction[galery_id]"
      assert_select "input#attraction_name[name=?]", "attraction[name]"
      assert_select "textarea#attraction_description[name=?]", "attraction[description]"
      assert_select "input#attraction_slug[name=?]", "attraction[slug]"
    end
  end
end
