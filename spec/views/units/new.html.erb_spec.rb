require 'rails_helper'

RSpec.describe "units/new", type: :view do
  before(:each) do
    assign(:unit, Unit.new(
      unit_type: "MyType",
      name: "MyName"
    ))
  end

  it "renders new unit form" do
    render

    assert_select "form[action=?][method=?]", units_path, "post" do

      assert_select "input[name=?]", "unit[unit_type]"

      assert_select "input[name=?]", "unit[name]"
    end
  end
end
