class CreateRegions < ActiveRecord::Migration
  def up
    create_table :regions do |t|
      t.integer :country_id
      t.integer :galery_id
      t.string :name
      t.text :description
      t.text :meta_description
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :regions, :slug, unique: true
    Region.create_translation_table! :name => :string, :description => :text, :meta_description => :text
  end

  def down
    remove_index :regions, :slug
    drop_table :regions
    Region.drop_translation_table!
  end
end
