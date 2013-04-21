class CreateTours < ActiveRecord::Migration
  def up
    create_table :tours do |t|
      t.integer :currency_id
      t.integer :photo_id
      t.integer :price_from
      t.integer :price_to
      t.boolean :active
      t.string :title
      t.text :description
      t.text :transport_description
      t.text :price_list
      t.text :price_included
      t.text :price_excluded
      t.text :note
      t.text :excursions
      t.text :seo_meta
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :tours, :slug, unique: true
    Tour.create_translation_table!({
      title: :string, 
      description: :text, 
      transport_description: :text, 
      price_list: :text,
      price_included: :text, 
      price_excluded: :text,
      note: :text,
      excursions: :text,
      seo_meta: :text
    })
  end
  def down
    remove_index :tours, :slug
    drop_table :tours 
    Tour.drop_translation_table!
  end
end
