require 'rails_helper'

RSpec.describe "roles/index", type: :view do
  before(:each) do
    assign(:roles, [
      Role.create!(role: "Role1"),
      Role.create!(role: "Role2")
    ])
  end

  it "renders a list of roles" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Role1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Role2".to_s), count: 1
  end
end
