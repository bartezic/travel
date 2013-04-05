class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.string :title
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :galleries, :slug, unique: true
    Gallery.create_translation_table!({ title: :string })
  end

  def down
    remove_index :galleries, :slug
    drop_table :galleries
    Gallery.drop_translation_table!
  end
end
