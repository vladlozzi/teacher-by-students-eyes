class CreateUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :units do |t|
      t.string :type, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_index :units, :name, unique: true
  end
end
