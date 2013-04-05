class CreateVisas < ActiveRecord::Migration
  def up
    create_table :visas do |t|
      t.integer :country_id
      t.integer :visa_type_id
      t.text :description

      t.timestamps
    end
    Visa.create_translation_table!({ description: :text })
  end

  def down
    drop_table :visas
    Visa.drop_translation_table! 
  end
end
