require 'rails_helper'

RSpec.describe "units/show", type: :view do
  before(:each) do
    assign(:unit, Unit.create!(
      unit_type: "MyType",
      name: "MyName"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyType$/)
    expect(rendered).to match(/MyName$/)
  end
end
