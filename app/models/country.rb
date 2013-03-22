class Country < ActiveRecord::Base
  belongs_to :continent
  has_many :regions
  
  translates :name, :visa, :description, :kitchen, :recomendation
  attr_accessible :continent_id, :name, :visa, :description, :kitchen, :recomendation

  active_admin_translates :name, :visa, :description, :kitchen, :recomendation do
    validates_presence_of :name
  end
end
