require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:person1) { Person.new }
  let(:person2) { Person.new }

  it "is not valid without fullname and email" do
    expect(person1).not_to be_valid
    expect(person1.errors.messages[:full_name]).to eq(["Введіть прізвище, ім'я та по батькові (за наявності)!"])
    expect(person1.errors.messages[:email]).to eq(["Введіть корпоративний email!", "Некоректний email"])
  end

  it "is not valid with fullname and incorrect email" do
    person1.full_name = "1st person's full name"
    person1.email = "1st person's email"
    expect(person1).not_to be_valid
    expect(person1.errors.messages[:email]).to eq(["Некоректний email"])
  end

  it "is valid with fullname and correct email" do
    person1.full_name = "1st person's full name"
    person1.email = "person1@email.com"
    expect(person1).to be_valid
  end

  it "is invalid if fullname is not unique" do
    person1.full_name = "1st person's full name"
    person1.email = "person1@email.com"
    person1.save
    person2.full_name = "1st person's full name"
    person2.email = "person2@email.com"
    expect(person2).not_to be_valid
    expect(person2.errors.messages[:full_name]).to eq(["Особа з таким прізвищем, іменем та по батькові вже є."])
    person2.full_name = "2st person's full name"
    person2.email = "person1@email.com"
    expect(person2).not_to be_valid
    expect(person2.errors.messages[:email]).to eq(["Особа з таким email вже є."])
  end

  it "is valid with different fullname and email" do
    person1.full_name = "1st person's full name"
    person1.email = "person1@email.com"
    expect(person1).to be_valid
    person1.save
    person2.full_name = "2st person's full name"
    person2.email = "person2@email.com"
    expect(person2).to be_valid
  end
end