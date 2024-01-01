require 'rails_helper'

RSpec.describe "student_teachers/show", type: :view do
  before(:each) do
    assign(:student_teacher, StudentTeacher.create!(
      student_distribution: StudentDistribution.create!(
        student: Student.create!(full_name: "Student1Distr", edebo_person_code: "1555"),
        group: Group.create!(group: "Group1ForStudentDistr"),
        edebo_study_code: "1111",
        email: "stud1-group1@email.com"
      ),
      teacher_distribution: TeacherDistribution.create!(
        person: Person.create!(full_name: "Person1Distr", email: "email1@email.com"),
        unit: Unit.create!(name: "Unit1ForDistr", unit_type: "Department")
      )
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Student1Distr/)
    expect(rendered).to match(/Group1ForStudentDistr/)
    expect(rendered).to match(/Person1Distr/)
    expect(rendered).to match(/Unit1ForDistr/)
  end
end
