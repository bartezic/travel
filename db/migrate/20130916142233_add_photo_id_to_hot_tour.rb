class AddPhotoIdToHotTour < ActiveRecord::Migration
  def change
    add_column :hot_tours,   :photo_id, :integer

    add_index :hot_tours,   :photo_id
  end
end
