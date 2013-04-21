class CreateToursFoodTypes < ActiveRecord::Migration
  def change  
    create_table :tours_food_types do |t|
      t.integer :tour_id
      t.integer :food_type_id
    end
  end
end
