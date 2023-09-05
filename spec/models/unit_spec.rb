require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit1) { Unit.new }
  let(:unit2) { Unit.new }

  it "is not valid without unit type and name" do
    expect(unit1).not_to be_valid
    expect(unit1.errors.messages[:unit_type]).to eq(["Введіть вид структурної одиниці!"])
    expect(unit1.errors.messages[:name]).to eq(["Введіть назву структурної одиниці!"])
  end

  it "is valid with unit type and name" do
    unit1.name = "1st unit name"
    unit1.unit_type = "1st unit type"
    expect(unit1).to be_valid
  end

  it "is invalid if unit name is not unique" do
    unit1.name = "1st unit name"
    unit1.unit_type = "1st unit type"
    unit1.save
    unit2.name = "1st unit name"
    unit2.unit_type = "1st unit type"
    expect(unit2).not_to be_valid
    expect(unit2.errors.messages[:name]).to eq(["Структурна одиниця з такою назвою вже є."])
  end

  it "is valid with different unit name" do
    unit1.name = "1st unit name"
    unit1.unit_type = "1st unit type"
    unit1.save
    unit2.name = "2st unit name"
    unit2.unit_type = "1st unit type"
    expect(unit2).to be_valid
    end
end
