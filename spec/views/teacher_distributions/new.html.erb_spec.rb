require 'rails_helper'

RSpec.describe "teacher_distributions/new", type: :view do
  before(:each) do
    assign(:teacher_distribution, TeacherDistribution.new)
  end

  it "renders new teacher_distribution form" do
    Unit.create!(name: "Unit1ForDistr", unit_type: "Department")
    @units_for_select = Unit.all
    Person.create!(full_name: "Person1Distr", email: "email1@email.com")
    @persons_for_select = Person.all
    render

    assert_select "form[action=?][method=?]", teacher_distributions_path, "post" do
      assert_select "select[name=?]", "teacher_distribution[unit_id]"
      assert_select "select[name=?]", "teacher_distribution[person_id]"
    end
    assert_select "select#teacher_distribution_unit_id" do
      assert_select "option[value=?]", @units_for_select.first.to_s
    end
    assert_select "select#teacher_distribution_person_id" do
      assert_select "option[value=?]", @persons_for_select.first.to_s
    end
  end
end
