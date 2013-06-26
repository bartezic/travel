class Tag < ActiveRecord::Base
  default_scope :order => 'tags.title ASC'

  has_many :taggings
  has_many :tours,  through: :taggings, source: :taggable, source_type: Tour
  has_many :tours,  through: :taggings, source: :taggable, source_type: Continent
  has_many :tours,  through: :taggings, source: :taggable, source_type: Country
  has_many :tours,  through: :taggings, source: :taggable, source_type: Region
  has_many :tours,  through: :taggings, source: :taggable, source_type: Hotel
  has_many :tours,  through: :taggings, source: :taggable, source_type: Attraction

  attr_accessible :title, :tours_ids, :continents_ids, :countries_ids, :regions_ids, 
                  :attractions_ids, :hotels_ids, :tagging_ids
  
  translates :title
  active_admin_translates :title do
    validates_presence_of :title
  end
end
