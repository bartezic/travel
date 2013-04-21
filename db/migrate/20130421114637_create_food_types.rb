class CreateFoodTypes < ActiveRecord::Migration
  def up
    create_table :food_types do |t|
      t.string :title
      t.string :code

      t.timestamps
    end
    FoodType.create_translation_table!({ title: :string })
  end
  def down
    drop_table :food_types
    FoodType.drop_translation_table!
  end
end
