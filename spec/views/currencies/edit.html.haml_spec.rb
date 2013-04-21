require 'spec_helper'

describe "currencies/edit" do
  before(:each) do
    @currency = assign(:currency, stub_model(Currency,
      :code => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit currency form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", currency_path(@currency), "post" do
      assert_select "input#currency_code[name=?]", "currency[code]"
      assert_select "input#currency_description[name=?]", "currency[description]"
    end
  end
end
