require 'rails_helper'

RSpec.describe "criteria/index", type: :view do
  before(:each) do
    assign(:criteria, [
      Criterium.create!(
        name: "Name1",
        scale: "Scale"
      ),
      Criterium.create!(
        name: "Name2",
        scale: "Scale"
      )
    ])
  end

  it "renders a list of criteria" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Name2".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Scale".to_s), count: 0
  end
end
