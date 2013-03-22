class Region < ActiveRecord::Base
  belongs_to :galery
  belongs_to :country
  has_many :attractions
  has_many :hotels
  attr_accessible :country_id, :description, :galery_id, :name
  translates :name, :description, :meta_description

  active_admin_translates :name, :description do
    validates_presence_of :name
  end
end
