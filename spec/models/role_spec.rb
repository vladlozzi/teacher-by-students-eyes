require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role1) { Role.new }
  let(:role2) { Role.new }

  it "is not valid without role name" do
    expect(role1).not_to be_valid
    expect(role1.errors.messages[:role]).to eq(["Введіть назву ролі користувача!"])
  end

  it "is valid with unit type and name" do
    role1.role = "1st role name"
    expect(role1).to be_valid
  end

  it "is invalid if role name is not unique" do
    role1.role = "1st role name"
    role1.save
    role2.role = "1st role name"
    expect(role2).not_to be_valid
    expect(role2.errors.messages[:role]).to eq(["Роль користувача з такою назвою вже є."])
  end

  it "is valid with different role name" do
    role1.role = "1st role name"
    role1.save
    role2.role = "2st role name"
    expect(role2).to be_valid
  end
end
