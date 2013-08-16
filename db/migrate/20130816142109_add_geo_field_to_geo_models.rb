class AddGeoFieldToGeoModels < ActiveRecord::Migration
  def change
    add_column :continents,   :geo, :text
    add_column :countries,    :geo, :text
    add_column :regions,      :geo, :text
    add_column :attractions,  :geo, :text
    add_column :hotels,       :geo, :text
  end
end
