class AddAssetRemoteUrlToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :asset_remote_url, :string
  end
end
