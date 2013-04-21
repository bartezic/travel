class CreateGalleriesPhotosTable < ActiveRecord::Migration
  def change
    create_table :galleries_photos do |t|
      t.integer :gallery_id
      t.integer :photo_id
    end
  end
end
