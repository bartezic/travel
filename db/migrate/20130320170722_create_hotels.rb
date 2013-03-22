class CreateHotels < ActiveRecord::Migration
  def up
    create_table :hotels do |t|
      t.integer :region_id
      t.integer :galery_id
      t.string :name
      t.text :description
      t.text :meta_description
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :hotels, :slug, unique: true
    Hotel.create_translation_table! :name => :string, :description => :text, :meta_description => :text
  end

  def down
    remove_index :hotels, :slug
    drop_table :hotels 
    Hotel.drop_translation_table! 
  end
end
