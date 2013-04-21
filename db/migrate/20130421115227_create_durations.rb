class CreateDurations < ActiveRecord::Migration
  def change
    create_table :durations do |t|
      t.integer :count_of_night

      t.timestamps
    end
  end
end
