require 'rails_helper'

RSpec.describe "groups/show", type: :view do
  before(:each) do
    assign(:group, Group.create!(group: "Group1"))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Group1/)
  end
end
