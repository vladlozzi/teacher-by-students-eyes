require 'rails_helper'

RSpec.describe "students/show", type: :view do
  before(:each) do
    assign(:student, Student.create!(
      full_name: "Full Name",
      edebo_person_code: "Person Code in EDEBO"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Full Name/)
    expect(rendered).to match(/Person Code in EDEBO/)
  end
end
