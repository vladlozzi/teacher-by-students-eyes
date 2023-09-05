require 'rails_helper'

RSpec.describe "roles/show", type: :view do
  before(:each) do
    assign(:role, Role.create!(role: "Role"))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Role/)
  end
end
