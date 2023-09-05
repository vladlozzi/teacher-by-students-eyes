require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group1) { Group.new }
  let(:group2) { Group.new }

  it "is not valid without group name" do
    expect(group1).not_to be_valid
    expect(group1.errors.messages[:group]).to eq(["Введіть назву академічної групи!"])
  end

  it "is valid with unit type and name" do
    group1.group = "1st group name"
    expect(group1).to be_valid
  end

  it "is invalid if group name is not unique" do
    group1.group = "1st group name"
    group1.save
    group2.group = "1st group name"
    expect(group2).not_to be_valid
    expect(group2.errors.messages[:group]).to eq(["Академічна група з такою назвою вже є."])
  end

  it "is valid with different group name" do
    group1.group = "1st group name"
    group1.save
    group2.group = "2st group name"
    expect(group2).to be_valid
  end
end
