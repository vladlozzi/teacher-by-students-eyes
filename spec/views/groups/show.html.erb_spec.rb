require 'rails_helper'

RSpec.describe "groups/show", type: :view do
  before(:each) do
    assign(:group, Group.create!(group: "Group_for_show"))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Шифр академгрупи:/)
    expect(rendered).to match(/Group_for_show/)
  end
end
