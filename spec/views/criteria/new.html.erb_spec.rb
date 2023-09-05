require 'rails_helper'

RSpec.describe "criteria/new", type: :view do
  before(:each) do
    assign(:criterium, Criterium.new(
      name: "MyString",
      scale: "MyString"
    ))
  end

  it "renders new criterium form" do
    render

    assert_select "form[action=?][method=?]", criteria_path, "post" do

      assert_select "input[name=?]", "criterium[name]"

      assert_select "input[name=?]", "criterium[scale]"
    end
  end
end
