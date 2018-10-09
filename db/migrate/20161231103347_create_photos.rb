class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :photos do |t|
      t.references :imageable, polymorphic: true, null: false
      t.string :photo, null: false
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
