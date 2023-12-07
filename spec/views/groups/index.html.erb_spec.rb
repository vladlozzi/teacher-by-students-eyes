require 'rails_helper'

RSpec.describe "groups/index", type: :view do
  before(:each) do
    assign(:groups, [
      Group.create!(
        group: "Group_for_index1"
      ),
      Group.create!(
        group: "Group_for_index2"
      )
    ])
  end

  it "renders a list of groups" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Group_for_index1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Group_for_index2".to_s), count: 1
  end
end
