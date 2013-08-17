class Country < ActiveRecord::Base
  extend FriendlyId
  serialize :geo, JSON

  default_scope :order => 'countries.name ASC'
  
  belongs_to :photo
  has_many :regions
  has_one :visa
  has_and_belongs_to_many :continents,  :join_table => :continents_countries
  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable
  
  attr_accessible :id, :continent_ids, :photo_id, :name, :description, :seo_meta, :kitchen, 
                  :recomendation, :climate, :culture, :infrastructure, :code, :tag_ids, 
                  :tags_attributes, :all_tags, :geo, :geo_input, :static_map, :geo_viewport, 
                  :parsed_geo

  accepts_nested_attributes_for :tags
  
  friendly_id :name, use: :slugged

  translates :name, :description, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure
  active_admin_translates :name, :description, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure do
    validates_presence_of :name
  end

  def geo_viewport
    parsed_geo['geometry']['viewport'] if parsed_geo
  end

  def static_map
    "https://maps.googleapis.com/maps/api/staticmap?center=#{parsed_geo['formatted_address']}&size=570x400&visual_refresh=true&sensor=true&language=#{I18n.locale}" if parsed_geo
  end

  def parsed_geo
    JSON.parse(geo) if geo
  end

  def geo_input
    ''
  end

  def geo_input=(val)
    ''
  end

  def all_tags
    tags.pluck(:title) + regions.joins(:tags).pluck(:'tags.title')
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
