class TeacherDistribution < ApplicationRecord
  has_many :student_teachers
  has_many :surveys, through: :student_teachers

  belongs_to :person
  belongs_to :unit

  validates :person, presence: {message: "Виберіть особу!"}
  validates :unit, presence: {message: "Виберіть структурний підрозділ!"}
  validates :person, uniqueness: {
    scope: :unit,
    message: "Ця особа вже є в цьому структурному підрозділі!"
  }

  def self.truncate
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
  end
end
