class CreateContinentsCountriesTable < ActiveRecord::Migration
  def up
    create_table :continents_countries do |t|
      t.integer :continent_id
      t.integer :country_id
    end
  end

  def down
    remove_table :continents_countries
  end
end
