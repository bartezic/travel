class CreateRegions < ActiveRecord::Migration
  def up
    create_table :regions do |t|
      t.integer :country_id
      t.integer :gallery_id
      t.string :name
      t.text :description
      t.text :seo_meta
      t.text :recomendation
      t.text :infrastructure
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :regions, :slug, unique: true
    Region.create_translation_table!({
      name: :string, 
      description: :text, 
      seo_meta: :text, 
      recomendation: :text, 
      infrastructure: :text
    })
  end

  def down
    remove_index :regions, :slug
    drop_table :regions
    Region.drop_translation_table!
  end
end
