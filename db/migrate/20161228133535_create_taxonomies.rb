class CreateTaxonomies < ActiveRecord::Migration[4.2]
  def change
    create_table :families do |t|
      t.string :name, null: false, unique: true
      t.string :description
      t.integer :major_group, null: false

      t.timestamps
    end

    create_table :genera do |t|
      t.string :name, null: false, unique: true
      t.string :description
      t.boolean :hybrid, null: false, default: false
      t.references :family, null: false

      t.timestamps
    end

    create_table :species do |t|
      t.string :name, null: false, unique: true
      t.string :common_name
      t.string :description
      t.string :authorship
      t.string :source
      t.string :source_id, foreign_key: false
      t.string :combined_source_id, foreign_key: false
      t.string :ipni_id, foreign_key: false
      t.string :publication
      t.string :collation
      t.integer :date
      t.string :infraspecific_rank
      t.string :infraspecific_epithet
      t.integer :taxonomic_status, null: false
      t.integer :confidence_level
      t.boolean :hybrid, null: false, default: false
      t.references :genus, null: false

      t.timestamps
    end

    create_table :plants do |t|
      t.references :species, null: false, unique: true

      t.timestamps
    end
  end
end
