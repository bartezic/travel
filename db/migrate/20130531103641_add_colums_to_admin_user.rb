class AddColumsToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :vk_token, :string
    add_column :admin_users, :fb_token, :string
  end
end
