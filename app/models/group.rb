class Group < ApplicationRecord
  validates :group, presence: {message: "Введіть назву академічної групи!"},
            uniqueness: {message: "Академічна група з такою назвою вже є."}
  has_many :student_distributions

  def self.truncate
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE `#{self.table_name}`")
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
  end
end
