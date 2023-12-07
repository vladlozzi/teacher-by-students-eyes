require 'rails_helper'

RSpec.describe StudentDistribution, type: :model do
  let(:sd1) { StudentDistribution.new }
  let(:sd2) { StudentDistribution.new }

  it "is not valid without attribites" do
    expect(sd1).not_to be_valid
    expect(sd1.errors.messages[:student]).to eq(["must exist", "Виберіть студента/студентку!"])
    expect(sd1.errors.messages[:group]).to eq(["must exist", "Виберіть академгрупу!"])
    expect(sd1.errors.messages[:email]).to eq(["Введіть корпоративний email!", "Введіть коректний email!"])
    expect(sd1.errors.messages[:edebo_study_code]).to eq(["Введіть код навчання ЄДЕБО!"])
  end

  it "is valid with fullname and person code" do
    sd1.student = Student.create!(full_name: "Student1Distr", edebo_person_code: "1555")
    sd1.group = Group.create!(group: "Group1ForStudentDistr")
    sd1.edebo_study_code = 111111111
    sd1.email = "email1@email.com"
    expect(sd1).to be_valid
  end
end
