class AddScientistIdsToPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :orcid, :string
    add_column :people, :scopus_authorid, :string
    add_column :people, :wos_researcherid, :string
  end
end
