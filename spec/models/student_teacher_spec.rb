require 'rails_helper'

RSpec.describe StudentTeacher, type: :model do
  let(:st_empty) { StudentTeacher.new }
  let(:st1) {
    StudentTeacher.create!(
      student_distribution: StudentDistribution.create!(
        student: Student.create!(full_name: "Student 1 Distr", edebo_person_code: "1555"),
        group: Group.create!(group: "Group 1 Distr"),
        edebo_study_code: 111111111,
        email: "stud1@email.com"
      ),
      teacher_distribution: TeacherDistribution.create!(
        person: Person.create!(full_name: "Teacher 1 Distr", email: "teacher1@email.com"),
        unit: Unit.create!(name: "Unit 1 Distr", unit_type: "Type")
      )
    )
  }
  let(:st2) { StudentTeacher.new }

  it "is not valid without attribites" do
    expect(st_empty).not_to be_valid
    expect(st_empty.errors.messages[:student_distribution]).to eq(["must exist", "Виберіть студента/студентку!"])
    expect(st_empty.errors.messages[:teacher_distribution]).to eq(["must exist", "Виберіть викладача/викладачку!"])
  end

  it "is valid with student and teacher" do
    expect(st1).to be_valid
  end

  it "is not valid with same student and teacher" do
    st1.save
    st2.student_distribution = st1.student_distribution
    st2.teacher_distribution = st1.teacher_distribution
    expect(st2).not_to be_valid
    expect(st2.errors.messages[:teacher_distribution]).to eq(['Ця пара "студент-викладач" вже є.'])
  end

  it "is valid with other teacher for student" do
    st1.save
    st2.student_distribution = st1.student_distribution
    st2.teacher_distribution = TeacherDistribution.create!(
      person: Person.create!(full_name: "Teacher 2 Distr", email: "teacher2@email.com"),
      unit: Unit.create!(name: "Unit 2 Distr", unit_type: "Type")
    )
    expect(st2).to be_valid
  end
end
