require 'rails_helper'

RSpec.describe Survey, type: :model do
  let(:survey_empty) { Survey.new }
  let(:survey1) {
    Survey.create!(
      student_teacher: StudentTeacher.create!(
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
      ),
      criterium: Criterium.create!(name: "Crit 1 Name", scale: "Crit 1 Scale")
    )
  }
  let(:survey2) { Survey.new }

  it "is not valid without attribites" do
    expect(survey_empty).not_to be_valid
    expect(survey_empty.errors.messages[:student_teacher]).to eq(["must exist", 'Виберіть пару "студент-викладач"!'])
    expect(survey_empty.errors.messages[:criterium]).to eq(["must exist", "Виберіть критерій!"])
  end

  it "is valid with student, teacher and criterium" do
    expect(survey1).to be_valid
  end

  it "is not valid with same student-teacher-criterium" do
    survey1.save
    survey2.student_teacher = survey1.student_teacher
    survey2.criterium = survey1.criterium
    expect(survey2).not_to be_valid
    expect(survey2.errors.messages[:criterium]).to eq(['Ця трійка "студент-викладач-критерій" вже є.'])
  end

  it "is valid with other criterium for student-teacher" do
    survey1.save
    survey2.student_teacher = survey1.student_teacher
    survey2.criterium = Criterium.create!(name: "Crit 2 Name", scale: "Crit 1 Scale")
    expect(survey2).to be_valid
  end
end
