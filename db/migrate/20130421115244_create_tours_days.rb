class CreateToursDays < ActiveRecord::Migration
  def change  
    create_table :tours_days do |t|
      t.integer :tour_id
      t.integer :day_id
    end
  end
end
