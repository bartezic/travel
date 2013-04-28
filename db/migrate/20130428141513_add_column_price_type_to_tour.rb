class AddColumnPriceTypeToTour < ActiveRecord::Migration
  def change
    add_column :tours, :price_type, :string
  end
end
