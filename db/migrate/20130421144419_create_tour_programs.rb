class CreateTourPrograms < ActiveRecord::Migration
  def up
    create_table :tour_programs do |t|
      t.integer :tour_id
      t.string :day_number
      t.text :description

      t.timestamps
    end
    TourProgram.create_translation_table!({ description: :text })
  end
  def down
    drop_table :tour_programs
    TourProgram.drop_translation_table!
  end
end
