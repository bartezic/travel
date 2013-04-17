class RemoveContinentIdColumnFromCountryTable < ActiveRecord::Migration
  def up
    remove_column :countries, :continent_id
  end

  def down
    add_column :countries, :continent_id, :integer
  end
end
