class Continent < ActiveRecord::Base
  has_many :countries
  
  translates :description, :name
  attr_accessible :description, :name

  active_admin_translates :name, :description do
    validates_presence_of :name
  end
end
