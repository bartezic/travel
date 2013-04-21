class CreateToursRegions < ActiveRecord::Migration
  def change  
    create_table :tours_regions do |t|
      t.integer :tour_id
      t.integer :region_id
    end
  end
end
