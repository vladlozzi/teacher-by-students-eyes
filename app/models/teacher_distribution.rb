class TeacherDistribution < ApplicationRecord
  belongs_to :person
  belongs_to :unit

  validates :person, presence: {message: "Виберіть особу!"}
  validates :unit, presence: {message: "Виберіть структурний підрозділ!"}
  validates :person, uniqueness: {
    scope: :unit,
    message: "Ця особа вже є в цьому структурному підрозділі!"
  }

  def self.truncate
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
  end
end
