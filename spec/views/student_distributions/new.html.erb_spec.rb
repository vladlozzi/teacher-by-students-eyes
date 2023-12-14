require 'rails_helper'

RSpec.describe "student_distributions/new", type: :view do
  before(:each) do
    assign(:student_distribution, StudentDistribution.new)
  end

  it "renders new student_distribution form" do
    Group.create!(group: "GroupForStudentDistrNew")
    @groups_for_select = Group.all
    Student.create!(full_name: "FullNameForStudentDistrNew", edebo_person_code: "15")
    @students_for_select = Student.all

    render

    assert_select "form[action=?][method=?]", student_distributions_path, "post" do
      assert_select "select[name=?]", "student_distribution[student_id]"
      assert_select "select[name=?]", "student_distribution[group_id]"
      assert_select "input[name=?]", "student_distribution[edebo_study_code]"
      assert_select "input[name=?]", "student_distribution[email]"
    end
    assert_select "select#student_distribution_group_id" do
      assert_select "option[value=?]", @groups_for_select.first.to_s
    end
    assert_select "select#student_distribution_student_id" do
      assert_select "option[value=?]", @students_for_select.first.to_s
    end
  end
end
