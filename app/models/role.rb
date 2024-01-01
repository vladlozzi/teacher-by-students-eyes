class Role < ApplicationRecord
  validates :role, presence: {message: "Введіть назву ролі користувача!"},
            uniqueness: {message: "Роль користувача з такою назвою вже є."}

  def self.truncate
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE #{self.table_name}")
    ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
  end
end
