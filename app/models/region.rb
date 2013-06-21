class Region < ActiveRecord::Base
  extend FriendlyId

  default_scope :order => 'regions.country_id ASC, regions.name ASC'

  belongs_to :gallery
  belongs_to :country
  has_many :attractions
  has_many :hotels
  has_and_belongs_to_many :tours,         :join_table => :tours_regions
  has_and_belongs_to_many :tour_programs, :join_table => :tour_programs_regions
  has_and_belongs_to_many :keywords,      :join_table => :regions_keywords

  attr_accessible :country_id, :description, :gallery_id, :name, :seo_meta, :recomendation, 
                  :infrastructure, :keyword_ids, :keywords_attributes

  accepts_nested_attributes_for :keywords
  
  friendly_id :name, use: :slugged

  translates :name, :description, :seo_meta, :recomendation, :infrastructure
  active_admin_translates :name, :description, :recomendation, :infrastructure, :seo_meta do
    validates_presence_of :name
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
