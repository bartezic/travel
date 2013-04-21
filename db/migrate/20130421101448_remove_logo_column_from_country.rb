class RemoveLogoColumnFromCountry < ActiveRecord::Migration
  def up
    drop_attached_file :countries, :logo
  end

  def down
    add_column :countries, :logo, :attachment
  end
end
