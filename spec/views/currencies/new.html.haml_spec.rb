require 'spec_helper'

describe "currencies/new" do
  before(:each) do
    assign(:currency, stub_model(Currency,
      :code => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new currency form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", currencies_path, "post" do
      assert_select "input#currency_code[name=?]", "currency[code]"
      assert_select "input#currency_description[name=?]", "currency[description]"
    end
  end
end
