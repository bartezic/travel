class CreateToursTourTypes < ActiveRecord::Migration
  def change  
    create_table :tours_tour_types do |t|
      t.integer :tour_id
      t.integer :tour_type_id
    end
  end
end
