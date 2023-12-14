class Unit < ApplicationRecord
  validates :name, presence: {message: "Введіть назву структурної одиниці!"},
            uniqueness: {message: "Структурна одиниця з такою назвою вже є."}
  validates :unit_type, presence: {message: "Введіть вид структурної одиниці!"}
  has_many :teacher_distributions
end
