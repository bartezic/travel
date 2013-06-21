class CreateToursKeywordsTable < ActiveRecord::Migration
  def change  
    create_table :tours_keywords do |t|
      t.integer :tour_id
      t.integer :keyword_id
    end
  end
end