class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :full_name, null: false
      t.string :email, null: false

      t.timestamps
    end
    add_index :people, :full_name, unique: true
    add_index :people, :email, unique: true
  end
end
