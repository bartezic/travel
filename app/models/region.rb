class Region < ActiveRecord::Base
  extend FriendlyId

  default_scope :order => 'regions.country_id ASC, regions.name ASC'

  belongs_to :gallery
  belongs_to :country
  has_many :attractions
  has_many :hotels
  has_and_belongs_to_many :tours,         :join_table => :tours_regions
  has_and_belongs_to_many :tour_programs, :join_table => :tour_programs_regions
  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable

  attr_accessible :country_id, :description, :gallery_id, :name, :seo_meta, :recomendation, 
                  :infrastructure, :tag_ids, :tags_attributes, :all_tags

  accepts_nested_attributes_for :tags
  
  friendly_id :name, use: :slugged

  translates :name, :description, :seo_meta, :recomendation, :infrastructure
  active_admin_translates :name, :description, :recomendation, :infrastructure, :seo_meta do
    validates_presence_of :name
  end

  def all_tags
    (tags.pluck(:title) + country.tags.pluck(:title) + attractions.joins(:tags).pluck(:'tags.title')).uniq
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
