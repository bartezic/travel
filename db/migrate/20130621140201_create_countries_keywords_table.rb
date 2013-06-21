class CreateCountriesKeywordsTable < ActiveRecord::Migration
  def change  
    create_table :countries_keywords do |t|
      t.integer :country_id
      t.integer :keyword_id
    end
  end
end
