class CreateTourTypes < ActiveRecord::Migration
  def up
    create_table :tour_types do |t|
      t.string :title
      t.string :code

      t.timestamps
    end
    TourType.create_translation_table!({ title: :string })
  end
  def down
    drop_table :tour_types
    TourType.drop_translation_table!
  end
end
