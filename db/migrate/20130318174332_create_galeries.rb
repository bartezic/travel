class CreateGaleries < ActiveRecord::Migration
  def up
    create_table :galeries do |t|
      t.string :title
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :galeries, :slug, unique: true
    Galery.create_translation_table! :title => :string
  end

  def down
    remove_index :galeries, :slug
    drop_table :galeries
    Galery.drop_translation_table!
  end
end
