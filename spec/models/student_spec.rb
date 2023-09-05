require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student1) { Student.new }
  let(:student2) { Student.new }

  it "is not valid without fullname and person code" do
    expect(student1).not_to be_valid
    expect(student1.errors.messages[:full_name]).to eq(["Введіть прізвище, ім'я та по батькові (за наявності)!"])
    expect(student1.errors.messages[:edebo_person_code]).to eq(["Введіть код персони в ЄДЕБО!"])
  end

  it "is valid with fullname and person code" do
    student1.full_name = "1st student's full name"
    student1.edebo_person_code = "111111111"
    expect(student1).to be_valid
  end

  it "is invalid if person code is not unique" do
    student1.full_name = "1st student's full name"
    student1.edebo_person_code = "11111111"
    student1.save
    student2.full_name = "2nd student's full name"
    student2.edebo_person_code = "11111111"
    expect(student2).not_to be_valid
    expect(student2.errors.messages[:edebo_person_code]).to eq(["Студент/студентка з таким кодом персони вже є."])
  end

  it "is valid with different person code" do
    student1.full_name = "Student's full name"
    student1.edebo_person_code = "11111111"
    expect(student1).to be_valid
    student1.save
    student2.full_name = "Student's full name"
    student2.edebo_person_code = "33333333"
    expect(student2).to be_valid
  end
end
