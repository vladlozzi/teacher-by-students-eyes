require 'rails_helper'

RSpec.describe "teacher_distributions/show", type: :view do
  before(:each) do
    assign(:teacher_distribution, TeacherDistribution.create!(
      unit: Unit.create!(name: "Unit1ForDistr", unit_type: "Department"),
      person: Person.create!(full_name: "Person1ForDistr", email: "email1@email.com")
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Unit1ForDistr/)
    expect(rendered).to match(/Person1ForDistr/)
  end
end
