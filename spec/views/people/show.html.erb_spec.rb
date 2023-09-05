require 'rails_helper'

RSpec.describe "people/show", type: :view do
  before(:each) do
    assign(:person, Person.create!(
      full_name: "Full Name",
      email: "full.name@example.com"
    ))
  end

  it "renders attributes" do
    render
    expect(rendered).to match(/Full Name/)
    expect(rendered).to match(/full\.name@example\.com/)
  end
end
