class CreateToursDurations < ActiveRecord::Migration
  def change  
    create_table :tours_durations do |t|
      t.integer :tour_id
      t.integer :duration_id
    end
  end
end
