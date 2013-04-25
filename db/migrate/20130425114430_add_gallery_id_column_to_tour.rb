class AddGalleryIdColumnToTour < ActiveRecord::Migration
  def change
    add_column :tours, :gallery_id, :integer
  end
end
