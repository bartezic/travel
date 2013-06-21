class CreateContinentsKeywords < ActiveRecord::Migration
  def change  
    create_table :continents_keywords do |t|
      t.integer :continent_id
      t.integer :keyword_id
    end
  end
end
