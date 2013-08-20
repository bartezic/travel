class AddPhotoIdToRegionAttractionHotel < ActiveRecord::Migration
  def change
    add_column :continents,   :photo_id, :integer
    add_column :regions,      :photo_id, :integer
    add_column :attractions,  :photo_id, :integer
    add_column :hotels,       :photo_id, :integer

    add_index :continents,   :photo_id
    add_index :regions,      :photo_id
    add_index :attractions,  :photo_id
    add_index :hotels,       :photo_id
  end
end
