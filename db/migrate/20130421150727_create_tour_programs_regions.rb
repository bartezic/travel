class CreateTourProgramsRegions < ActiveRecord::Migration
  def change  
    create_table :tour_programs_regions do |t|
      t.integer :tour_program_id
      t.integer :region_id
    end
  end
end
