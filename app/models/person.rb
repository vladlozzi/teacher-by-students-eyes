class Person < ApplicationRecord
  validates :full_name, presence: {message: "Введіть прізвище, ім'я та по батькові (за наявності)!"},
            uniqueness: {message: "Особа з таким прізвищем, іменем та по батькові вже є."}
  validates :email, presence: {message: "Введіть корпоративний email!"},
            uniqueness: {message: "Особа з таким email вже є."}
  validates_format_of :email,
                      with: URI::MailTo::EMAIL_REGEXP,
                      message: "Некоректний email"
  has_many :teacher_distributions

  def self.truncate
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
  end
end