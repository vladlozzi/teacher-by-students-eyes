require 'rails_helper'

RSpec.describe "units/index", type: :view do
  before(:each) do
    assign(:units, [
      Unit.create!(
        unit_type: "Type1",
        name: "Name1"
      ),
      Unit.create!(
        unit_type: "Type2",
        name: "Name2"
      ),
      Unit.create!(
        unit_type: "Type1",
        name: "Name3"
      )
    ])
  end

  it "renders a list of units" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Type1".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Type2".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Name1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Name2".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Name3".to_s), count: 1
  end
end
