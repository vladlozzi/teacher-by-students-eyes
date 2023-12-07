class CreateStudentDistributions < ActiveRecord::Migration[7.0]
  def change
    create_table :student_distributions do |t|
      t.references :student, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :edebo_study_code
      t.string :email

      t.timestamps
    end
    add_index :student_distributions, :edebo_study_code, unique: true
    add_index :student_distributions, :email, unique: true
  end
end
