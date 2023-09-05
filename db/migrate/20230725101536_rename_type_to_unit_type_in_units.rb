class RenameTypeToUnitTypeInUnits < ActiveRecord::Migration[7.0]
  def change
    rename_column :units, :type, :unit_type
  end
end
