require 'rails_helper'

RSpec.describe "student_teachers/new", type: :view do
  before(:each) do
    assign(:student_teacher, StudentTeacher.new)
  end

  it "renders new student_teacher form" do
    TeacherDistribution.create!(
      unit: Unit.create!(name: "Unit1ForDistr", unit_type: "Department"),
      person:  Person.create!(full_name: "Person1Distr", email: "email1@email.com")
    )
    StudentDistribution.create!(
      group: Group.create!(group: "GroupForStudentDistrNew"),
      student: Student.create!(full_name: "FullNameForStudentDistrNew", edebo_person_code: "15"),
      edebo_study_code: "1555", email: "stud-group@email.com"
    )
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

    assert_select "form[action=?][method=?]", student_teachers_path, "post" do
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
