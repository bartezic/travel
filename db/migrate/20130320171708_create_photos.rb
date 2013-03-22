class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.integer :galery_id
      t.string :title
      t.attachment :asset

      t.timestamps
    end
    Photo.create_translation_table! :title => :string
  end

  def down
    drop_table :photos 
    Photo.drop_translation_table! 
  end
end
