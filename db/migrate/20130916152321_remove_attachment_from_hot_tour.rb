class RemoveAttachmentFromHotTour < ActiveRecord::Migration
  def up
    drop_attached_file :hot_tours, :cover
  end

  def down
    change_table :hot_tours do |t|
      t.has_attached_file :cover
    end
  end
end
