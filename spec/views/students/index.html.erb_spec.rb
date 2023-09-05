require 'rails_helper'

RSpec.describe "students/index", type: :view do
  before(:each) do
    assign(:students, [
      Student.create!(
        full_name: "Full Name 1",
        edebo_person_code: "Code1"
      ),
      Student.create!(
        full_name: "Full Name 2",
        edebo_person_code: "Code2"
      )
    ])
  end

  it "renders a list of students" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Full Name 1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Full Name 2".to_s), count: 1
  end
end
