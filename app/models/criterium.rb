class Criterium < ApplicationRecord
  validates :name, presence: {message: "Введіть назву критерію!"},
            uniqueness: {message: "Критерій із такою назвою вже є."}
  validates :scale, presence: {message: "Введіть шкалу оцінювання!"}

  def self.truncate
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
  end
end
