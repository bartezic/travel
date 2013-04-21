class Transport < ActiveRecord::Base
  has_and_belongs_to_many :tours, :join_table => :tours_transports

  translates :title
  attr_accessible :code, :title

  active_admin_translates :title
end
