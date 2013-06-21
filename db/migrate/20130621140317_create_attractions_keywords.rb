class CreateAttractionsKeywords < ActiveRecord::Migration
  def change  
    create_table :attractions_keywords do |t|
      t.integer :attraction_id
      t.integer :keyword_id
    end
  end
end
