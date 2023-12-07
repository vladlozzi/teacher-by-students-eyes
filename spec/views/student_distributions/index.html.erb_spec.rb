require 'rails_helper'

RSpec.describe "student_distributions/index", type: :view do
  before(:each) do
    assign(:student_distributions, [
      StudentDistribution.create!(
        student: Student.create!(full_name: "Student1DistrIndex", edebo_person_code: "1555"),
        group: Group.create!(group: "Group1ForStudentDistrIndex"),
        edebo_study_code: "1111",
        email: "email1@email.com"
      ),
      StudentDistribution.create!(
        student: Student.create!(full_name: "Student2DistrIndex", edebo_person_code: "2555"),
        group: Group.create!(group: "Group2ForStudentDistrIndex"),
        edebo_study_code: "2222",
        email: "email2@email.com"
      )
    ])
  end

  it "renders a list of student_distributions" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Student1DistrIndex")
    assert_select cell_selector, text: Regexp.new("Group1ForStudentDistrIndex")
    assert_select cell_selector, text: Regexp.new("email1@email.com")
    assert_select cell_selector, text: Regexp.new("Student2DistrIndex")
    assert_select cell_selector, text: Regexp.new("Group2ForStudentDistrIndex")
    assert_select cell_selector, text: Regexp.new("email2@email.com")
  end
end
