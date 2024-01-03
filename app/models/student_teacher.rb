class StudentTeacher < ApplicationRecord
  belongs_to :student_distribution
  belongs_to :teacher_distribution
  has_many :surveys

  validates :student_distribution, presence: {message: "Виберіть студента/студентку!"}
  validates :teacher_distribution, presence: {message: "Виберіть викладача/викладачку!"}
  validates :teacher_distribution, uniqueness: {
    scope: :student_distribution,
    message: 'Ця пара "студент-викладач" вже є.'
  }

  def self.truncate
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
  end
end
