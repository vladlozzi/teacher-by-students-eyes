require 'rails_helper'

RSpec.describe "teacher_distributions/index", type: :view do
  before(:each) do
    unit = Unit.create!(name: "Unit1ForDistr", unit_type: "Department")
    assign(:teacher_distributions, [
      TeacherDistribution.create!(
        person: Person.create!(full_name: "Person1Distr", email: "email1@email.com"),
        unit: unit
      ),
      TeacherDistribution.create!(
        person: Person.create!(full_name: "Person2Distr", email: "email2@email.com"),
        unit: unit
      )
    ])
  end

  it "renders a list of teacher_distributions" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Unit1ForDistr".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Person1Distr".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Person2Distr".to_s), count: 1
  end
end
