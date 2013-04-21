class RemoveGalleryIdColumnFromPhoto < ActiveRecord::Migration
  def up
    remove_column :photos, :gallery_id
  end

  def down
    add_column :photos, :gallery_id, :integer
  end
end
