class CreateTeacherDistributions < ActiveRecord::Migration[7.0]
  def change
    create_table :teacher_distributions do |t|
      t.references :unit, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
