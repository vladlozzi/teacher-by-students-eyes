require 'rails_helper'

RSpec.describe "student_distributions/show", type: :view do
  before(:each) do
    assign(:student_distribution,
      StudentDistribution.create!(
        student: Student.create!(full_name: "Student1DistrShow", edebo_person_code: "1555"),
        group: Group.create!(group: "Group1ForStudentDistrShow"),
        edebo_study_code: "1111",
        email: "email1@email.com"
      )
    )

  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Student1DistrShow/)
    expect(rendered).to match(/Group1ForStudentDistrShow/)
    expect(rendered).to match(/1111/)
    expect(rendered).to match(/email1@email.com/)
  end
end
