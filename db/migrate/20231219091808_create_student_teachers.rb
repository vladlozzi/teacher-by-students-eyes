class CreateStudentTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :student_teachers do |t|
      t.references :student_distribution, null: false, foreign_key: true
      t.references :teacher_distribution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
