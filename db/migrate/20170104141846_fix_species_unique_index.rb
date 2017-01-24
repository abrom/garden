class FixSpeciesUniqueIndex < ActiveRecord::Migration[5.0]
  def up
    add_index :species,
      [:name, :genus_id, :infraspecific_rank, :infraspecific_epithet],
      unique: true,
      name: 'index_species_unique'
  end
end
