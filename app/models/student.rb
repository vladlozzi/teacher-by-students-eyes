class Student < ApplicationRecord
  validates :edebo_person_code, presence: {message: "Введіть код персони в ЄДЕБО!"},
            uniqueness: {message: "Студент/студентка з таким кодом персони вже є."}
  validates :full_name, presence: {message: "Введіть прізвище, ім'я та по батькові (за наявності)!"},
            uniqueness: {scope: :edebo_person_code, message: "Студент/студентка з таким кодом персони та ПІБ вже є."}
  has_many :student_distributions

  def self.truncate
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
  end
end
