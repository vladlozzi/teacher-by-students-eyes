require 'rails_helper'

RSpec.describe "units/edit", type: :view do
  let(:unit) {
    Unit.create!(
      unit_type: "MyUnit",
      name: "MyName"
    )
  }

  before(:each) do
    assign(:unit, unit)
  end

  it "renders the edit unit form" do
    render

    assert_select "form[action=?][method=?]", unit_path(unit), "post" do

      assert_select "input[name=?]", "unit[unit_type]"

      assert_select "input[name=?]", "unit[name]"
    end
  end
end
