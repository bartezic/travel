require 'spec_helper'

describe "tours/edit" do
  before(:each) do
    @tour = assign(:tour, stub_model(Tour,
      :currency_id => 1
    ))
  end

  it "renders the edit tour form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tour_path(@tour), "post" do
      assert_select "input#tour_currency_id[name=?]", "tour[currency_id]"
    end
  end
end
