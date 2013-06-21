class CreateRegionsKeywords < ActiveRecord::Migration
  def change  
    create_table :regions_keywords do |t|
      t.integer :region_id
      t.integer :keyword_id
    end
  end
end
