require 'rails_helper'

RSpec.describe "students/new", type: :view do
  before(:each) do
    assign(:student, Student.new(
      full_name: "MyString",
      edebo_person_code: "MyString"
    ))
  end

  it "renders new student form" do
    render

    assert_select "form[action=?][method=?]", students_path, "post" do

      assert_select "input[name=?]", "student[full_name]"

      assert_select "input[name=?]", "student[edebo_person_code]"
    end
  end
end
