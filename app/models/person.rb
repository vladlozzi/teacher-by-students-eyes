class Person < ApplicationRecord
  validates :full_name, presence: {message: "Введіть прізвище, ім'я та по батькові (за наявності)!"},
            uniqueness: {message: "Особа з таким прізвищем, іменем та по батькові вже є."}
  validates :email, presence: {message: "Введіть корпоративний email!"},
            uniqueness: {message: "Особа з таким email вже є."}
  validates_format_of :email,
                      with: URI::MailTo::EMAIL_REGEXP,
                      message: "Некоректний email"

  def self.truncate
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
  end
end