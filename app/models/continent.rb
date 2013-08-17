class Continent < ActiveRecord::Base
  extend FriendlyId
  serialize :geo, JSON
  
  default_scope :order => 'continents.name ASC'
  
  has_and_belongs_to_many :countries, :join_table => :continents_countries
  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable

  translates :description, :name, :seo_meta
  attr_accessible :description, :name, :tag_ids, :tags_attributes, :all_tags, :geo, :geo_input,
                  :static_map, :geo_viewport, :parsed_geo

  accepts_nested_attributes_for :tags
  
  friendly_id :name, use: :slugged
  
  active_admin_translates :name, :description do
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
    tags.pluck(:title) + countries.joins(:tags).pluck(:'tags.title').flatten.uniq    
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
