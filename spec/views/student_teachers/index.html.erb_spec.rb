require 'rails_helper'

RSpec.describe "student_teachers/index", type: :view do
  before(:each) do
    unit = Unit.create!(name: "Unit1ForDistr", unit_type: "Department")
    assign(:student_teachers, [
      StudentTeacher.create!(
        student_distribution: StudentDistribution.create!(
          student: Student.create!(full_name: "Student1DistrIndex", edebo_person_code: "1555"),
          group: Group.create!(group: "Group1ForStudentDistrIndex"),
          edebo_study_code: "1111",
          email: "stud1-group1@email.com"
        ),
        teacher_distribution: TeacherDistribution.create!(
          person: Person.create!(full_name: "Person1Distr", email: "email1@email.com"),
          unit: unit
        )
      ),
      StudentTeacher.create!(
        student_distribution: StudentDistribution.create!(
          student: Student.create!(full_name: "Student2DistrIndex", edebo_person_code: "2555"),
          group: Group.create!(group: "Group2ForStudentDistrIndex"),
          edebo_study_code: "2111",
          email: "stud2-gruop2@email.com"
        ),
        teacher_distribution: TeacherDistribution.create!(
          person: Person.create!(full_name: "Person2Distr", email: "email2@email.com"),
          unit: unit
        )
      )
    ])
  end

  it "renders a list of student_teachers" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Unit1ForDistr".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Person1Distr".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Person2Distr".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Group1ForStudentDistrIndex".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Group2ForStudentDistrIndex".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Student1DistrIndex".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Student2DistrIndex".to_s), count: 1
  end
end
