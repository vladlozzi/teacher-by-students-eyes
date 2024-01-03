class Survey < ApplicationRecord
  belongs_to :student_teacher
  belongs_to :criterium

  validates :student_teacher, presence: {message: 'Виберіть пару "студент-викладач"!'}
  validates :criterium, presence: {message: "Виберіть критерій!"}
  # validates :rating
  validates :criterium, uniqueness: {
    scope: :student_teacher,
    message: 'Ця трійка "студент-викладач-критерій" вже є.'
  }

  def self.truncate
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
  end
end
