class CreateAttractions < ActiveRecord::Migration
  def up
    create_table :attractions do |t|
      t.integer :region_id
      t.integer :galery_id
      t.string :name
      t.text :description
      t.text :meta_description
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :attractions, :slug, unique: true
    Attraction.create_translation_table! :name => :string, :description => :text, :meta_description => :text
  end

  def down
    remove_index :attractions, :slug
    drop_table :attractions 
    Attraction.drop_translation_table! 
  end
end
