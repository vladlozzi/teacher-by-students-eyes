require 'rails_helper'

RSpec.describe Criterium, type: :model do
  let(:criterium1) { Criterium.new }
  let(:criterium2) { Criterium.new }

  it "is not valid without criterium scale and name" do
    expect(criterium1).not_to be_valid
    expect(criterium1.errors.messages[:scale]).to eq(["Введіть шкалу оцінювання!"])
    expect(criterium1.errors.messages[:name]).to eq(["Введіть назву критерію!"])
  end

  it "is valid with criterium scale and name" do
    criterium1.name = "1st criterium name"
    criterium1.scale = "1st criterium scale"
    expect(criterium1).to be_valid
  end

  it "is invalid if criterium name is not unique" do
    criterium1.name = "1st criterium name"
    criterium1.scale = "1st criterium scale"
    criterium1.save
    criterium2.name = "1st criterium name"
    criterium2.scale = "1st criterium type"
    expect(criterium2).not_to be_valid
    expect(criterium2.errors.messages[:name]).to eq(["Критерій із такою назвою вже є."])
  end

  it "is valid with different criterium name" do
    criterium1.name = "1st criterium name"
    criterium1.scale = "1st criterium scale"
    criterium1.save
    criterium2.name = "2nd criterium name"
    criterium2.scale = "1st criterium scale"
    expect(criterium2).to be_valid
  end
end
