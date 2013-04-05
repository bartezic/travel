class CreateCountries < ActiveRecord::Migration
  def up
    create_table :countries do |t|
      t.integer :continent_id
      t.string :name
      t.text :kitchen
      t.text :description
      t.text :recomendation
      t.text :seo_meta
      t.text :climate
      t.text :culture
      t.text :infrastructure
      t.attachment :logo
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :countries, :slug, unique: true
    Country.create_translation_table!({
      name: :string, 
      kitchen: :text, 
      climate: :text,
      culture: :text,
      description: :text, 
      recomendation: :text, 
      infrastructure: :text,
      seo_meta: :text
    })
  end
  def down
    remove_index :countries, :slug
    drop_table :countries 
    Country.drop_translation_table!
  end
end
