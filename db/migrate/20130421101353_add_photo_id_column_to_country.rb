class AddPhotoIdColumnToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :photo_id, :integer
  end
end
