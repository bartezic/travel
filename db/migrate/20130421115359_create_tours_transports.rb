class CreateToursTransports < ActiveRecord::Migration
  def change  
    create_table :tours_transports do |t|
      t.integer :tour_id
      t.integer :transport_id
    end
  end
end
