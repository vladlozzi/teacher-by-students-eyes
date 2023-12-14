require 'rails_helper'

RSpec.describe "teacher_distributions/edit", type: :view do
  let(:teacher_distribution) {
    TeacherDistribution.create!(
      unit: Unit.create!(name: "Unit1ForDistr", unit_type: "Department"),
      person: Person.create!(full_name: "Person1Distr", email: "email1@email.com")
    )
  }

  before(:each) do
    assign(:teacher_distribution, teacher_distribution)
  end

  it "renders the edit teacher_distribution form" do
    @units_for_select = Unit.all
    @persons_for_select = Person.all
    render
    # p rendered
    assert_select "form[action=?][method=?]", teacher_distribution_path(teacher_distribution), "post" do
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
