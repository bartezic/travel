class CreateCountries < ActiveRecord::Migration
  def up
    create_table :countries do |t|
      t.integer :continent_id
      t.string :name
      t.text :visa
      t.text :kitchen
      t.text :description
      t.text :recomendation
      t.text :meta_description
      t.attachment :logo
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :countries, :slug, unique: true
    Country.create_translation_table! :name => :string, :visa => :text, :description => :text, :kitchen => :text, :recomendation => :text, :meta_description => :text
  end
  def down
    remove_index :countries, :slug
    drop_table :countries 
    Country.drop_translation_table!
  end
end
