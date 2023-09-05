class CreateCriteria < ActiveRecord::Migration[7.0]
  def change
    create_table :criteria do |t|
      t.string :name, null: false
      t.string :scale, null: false

      t.timestamps
    end
    add_index :criteria, :name, unique: true
  end
end
