require 'rails_helper'

RSpec.describe "students/edit", type: :view do
  let(:student) {
    Student.create!(
      full_name: "MyString",
      edebo_person_code: "MyString"
    )
  }

  before(:each) do
    assign(:student, student)
  end

  it "renders the edit student form" do
    render

    assert_select "form[action=?][method=?]", student_path(student), "post" do

      assert_select "input[name=?]", "student[full_name]"

      assert_select "input[name=?]", "student[edebo_person_code]"
    end
  end
end
