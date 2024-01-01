require 'rails_helper'

RSpec.describe "student_teachers/edit", type: :view do
  let(:student_teacher) {
    StudentTeacher.create!(
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
    )
  }

  before(:each) do
    assign(:student_teacher, student_teacher)
  end

  it "renders the edit student_teacher form" do
    @student_distributions_for_select =
      StudentDistribution.includes(:group).includes(:student).
        order("students.full_name, groups.group").
        pluck("students.full_name, groups.group, student_distributions.id").
        map{ |full_name, group, id| [full_name + " | " + group, id] }
    @teacher_distributions_for_select =
      TeacherDistribution.includes(:unit).includes(:person).
        order("people.full_name, units.name").
        pluck("people.full_name, units.name, teacher_distributions.id").
        map{ |full_name, unit_name, id| [full_name + " | " + unit_name, id] }

    render

    assert_select "form[action=?][method=?]", student_teacher_path(student_teacher), "post" do
      assert_select "select[name=?]", "student_teacher[student_distribution_id]"
      assert_select "select[name=?]", "student_teacher[teacher_distribution_id]"
      assert_select "select#student_teacher_student_distribution_id" do
        assert_select "option[value=?]", @student_distributions_for_select.first.last.to_s
      end
      assert_select "select#student_teacher_teacher_distribution_id" do
        assert_select "option[value=?]", @teacher_distributions_for_select.first.last.to_s
      end
    end
  end
end
