class StudentDistribution < ApplicationRecord
  belongs_to :student
  belongs_to :group

  validates :student, presence: {message: "Виберіть студента/студентку!"}
  validates :group, presence: {message: "Виберіть академгрупу!"}
  validates :edebo_study_code, presence: {message: "Введіть код навчання ЄДЕБО!"},
            uniqueness: {message: "Студент/студентка з таким кодом навчання вже є."}
  validates :email, presence: {message: "Введіть корпоративний email!"},
            uniqueness: {message: "Студент/студентка з таким email вже є."}
  validates_format_of :email,
                      with: URI::MailTo::EMAIL_REGEXP,
                      message: "Введіть коректний email!"

  def self.truncate
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
  end
end
