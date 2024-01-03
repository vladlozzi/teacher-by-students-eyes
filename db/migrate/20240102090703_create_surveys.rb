class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.references :student_teacher, null: false, foreign_key: true
      t.references :criterium, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
