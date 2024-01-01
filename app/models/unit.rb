class Unit < ApplicationRecord
  validates :name, presence: {message: "Введіть назву структурної одиниці!"},
            uniqueness: {message: "Структурна одиниця з такою назвою вже є."}
  validates :unit_type, presence: {message: "Введіть вид структурної одиниці!"}
  has_many :teacher_distributions

  def self.truncate
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
  end
end
