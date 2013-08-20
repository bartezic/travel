class Attraction < ActiveRecord::Base
  extend FriendlyId
  serialize :geo, JSON

  belongs_to :photo
  belongs_to :gallery
  belongs_to :region
  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable
  
  attr_accessible :name, :description, :seo_meta, :gallery_id, :region_id, :slug, 
                  :tag_ids, :tags_attributes, :all_tags, :geo, :geo_input, :photo_id

  accepts_nested_attributes_for :tags
  
  friendly_id :name, use: :slugged
  
  translates :name, :description, :seo_meta
  active_admin_translates :name, :description, :seo_meta do
    validates_presence_of :name
  end

  def geo_input
    ''
  end

  def geo_input=(val)
    ''
  end

  def all_tags
    tags.pluck(:title) + region.tags.pluck(:title) + region.country.tags.pluck(:title)
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
