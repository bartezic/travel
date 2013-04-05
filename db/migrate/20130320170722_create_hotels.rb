class CreateHotels < ActiveRecord::Migration
  def up
    create_table :hotels do |t|
      t.integer :region_id
      t.integer :gallery_id
      t.string :name
      t.text :description
      t.text :amenities
      t.text :policies
      t.text :seo_meta
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :hotels, :slug, unique: true
    Hotel.create_translation_table!({
      name: :string, 
      description: :text,
      amenities: :text,
      policies: :text,
      seo_meta: :text
    })
  end

  def down
    remove_index :hotels, :slug
    drop_table :hotels 
    Hotel.drop_translation_table! 
  end
end
