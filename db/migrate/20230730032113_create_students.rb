class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :full_name, null: false
      t.string :edebo_person_code, null: false

      t.timestamps
    end
    add_index :students, :edebo_person_code, unique: true
  end
end