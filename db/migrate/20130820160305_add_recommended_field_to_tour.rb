class AddRecommendedFieldToTour < ActiveRecord::Migration
  def change
    add_column :tours, :recommended, :boolean
  end
end
