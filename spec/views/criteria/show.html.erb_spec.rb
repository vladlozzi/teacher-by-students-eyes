require 'rails_helper'

RSpec.describe "criteria/show", type: :view do
  before(:each) do
    assign(:criterium, Criterium.create!(
      name: "Name1",
      scale: "Scale1"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name1/)
    expect(rendered).to match(/Scale1/)
  end
end
