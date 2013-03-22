class CreateContinents < ActiveRecord::Migration
  def up
    create_table :continents do |t|
      t.string :name
      t.text :description
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :continents, :slug, unique: true
    Continent.create_translation_table! :name => :string, :description => :text
  end
  def down
    remove_index :continents, :slug
    drop_table :continents
    Continent.drop_translation_table!
  end
end
