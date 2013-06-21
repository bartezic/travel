class Keyword < ActiveRecord::Base
  default_scope :order => 'keywords.title ASC'

  has_and_belongs_to_many :tours,       :join_table => :tours_keywords
  has_and_belongs_to_many :continents,  :join_table => :continents_keywords
  has_and_belongs_to_many :countries,   :join_table => :countries_keywords
  has_and_belongs_to_many :regions,     :join_table => :regions_keywords
  has_and_belongs_to_many :attractions, :join_table => :attractions_keywords
  has_and_belongs_to_many :hotels,      :join_table => :hotels_keywords  

  attr_accessible :title, :tours_ids, :continents_ids, :countries_ids, :regions_ids, 
                  :attractions_ids, :hotels_ids
  
  translates :title
  active_admin_translates :title do
    validates_presence_of :title
  end
end
