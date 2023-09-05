class Group < ApplicationRecord
  validates :group, presence: {message: "Введіть назву академічної групи!"},
            uniqueness: {message: "Академічна група з такою назвою вже є."}

  def self.truncate
    ActiveRecord::Base.connection.execute("TRUNCATE `#{self.table_name}`")
  end
end
