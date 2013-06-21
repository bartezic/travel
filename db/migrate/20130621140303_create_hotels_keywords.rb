class CreateHotelsKeywords < ActiveRecord::Migration
  def change  
    create_table :hotels_keywords do |t|
      t.integer :hotel_id
      t.integer :keyword_id
    end
  end
end
