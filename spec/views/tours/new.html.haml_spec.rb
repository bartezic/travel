require 'spec_helper'

describe "tours/new" do
  before(:each) do
    assign(:tour, stub_model(Tour,
      :currency_id => 1
    ).as_new_record)
  end

  it "renders new tour form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tours_path, "post" do
      assert_select "input#tour_currency_id[name=?]", "tour[currency_id]"
    end
  end
end
