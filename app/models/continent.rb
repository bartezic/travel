class Continent < ActiveRecord::Base
  default_scope :order => 'continents.name ASC'
  has_and_belongs_to_many :countries, :join_table => :continents_countries
  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable

  translates :description, :name, :seo_meta
  attr_accessible :description, :name, :tag_ids, :tags_attributes, :all_tags, :geo, :geo_input

  accepts_nested_attributes_for :tags

  active_admin_translates :name, :description do
    validates_presence_of :name
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

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
