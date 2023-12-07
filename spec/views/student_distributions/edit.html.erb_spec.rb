require 'rails_helper'

RSpec.describe "student_distributions/edit", type: :view do
  it "renders the edit student_distribution form" do
    group = Group.create!(group: "GroupForStudentDistrEdit")
    student = Student.create!(full_name: "FullNameForStudentDistrEdit", edebo_person_code: "15")
    @students_for_select = Student.all
    @groups_for_select = Group.all
    @student_distribution =
      StudentDistribution.create!(
        student: student,
        group: group,
        edebo_study_code: "15000000",
        email: "email@email.com"
      )

    render

    assert_select "form[action=?][method=?]", student_distribution_path(@student_distribution), "post" do

      assert_select "select[name=?]", "student_distribution[student_id]"

      assert_select "select[name=?]", "student_distribution[group_id]"

      assert_select "input[name=?]", "student_distribution[edebo_study_code]"

      assert_select "input[name=?]", "student_distribution[email]"
    end
  end
end
