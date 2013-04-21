class CreateContinentsCountries < ActiveRecord::Migration
  def change
    create_table :continents_countries do |t|
      t.integer :continent_id
      t.integer :country_id
    end
  end
end
