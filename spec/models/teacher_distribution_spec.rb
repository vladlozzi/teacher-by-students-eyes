require 'rails_helper'

RSpec.describe TeacherDistribution, type: :model do
  let(:td1) { TeacherDistribution.new }
  let(:td2) { TeacherDistribution.new }

  it "is not valid without attribites" do
    expect(td1).not_to be_valid
    expect(td1.errors.messages[:person]).to eq(["must exist", "Виберіть особу!"])
    expect(td1.errors.messages[:unit]).to eq(["must exist", "Виберіть структурний підрозділ!"])
  end

  it "is valid with person and unit" do
    td1.person = Person.create!(full_name: "Person1Distr", email: "person1@email.com")
    td1.unit = Unit.create!(name: "Unit1ForDistr", unit_type: "Department")
    expect(td1).to be_valid
  end

  it "is not valid with same person in unit" do
    td1.person = Person.create!(full_name: "Person1Distr", email: "person1@email.com")
    td1.unit = Unit.create!(name: "Unit1ForDistr", unit_type: "Department")
    td1.save
    td2.person = td1.person
    td2.unit = td1.unit
    expect(td2).not_to be_valid
    expect(td2.errors.messages[:person]).to eq(["Ця особа вже є в цьому структурному підрозділі!"])
  end

  it "is valid with differents persons in unit" do
    td1.person = Person.create!(full_name: "Person1Distr", email: "person1@email.com")
    td1.unit = Unit.create!(name: "Unit1ForDistr", unit_type: "Department")
    td1.save
    td2.person = Person.create!(full_name: "Person2Distr", email: "person2@email.com")
    td2.unit = td1.unit
    expect(td2).to be_valid
  end
end