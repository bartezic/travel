class Hotel < ActiveRecord::Base
  extend FriendlyId
  serialize :geo, JSON

  belongs_to :photo
  belongs_to :gallery
  belongs_to :region
  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable

  attr_accessible :name, :description, :seo_meta, :gallery_id, :region_id, :slug, :policies, 
                  :amenities, :star, :address, :phone, :email, :site, :tag_ids, 
                  :tags_attributes, :geo, :geo_input, :photo_id

  accepts_nested_attributes_for :tags

  friendly_id :name, use: :slugged

  translates :name, :description, :seo_meta, :policies, :amenities
  active_admin_translates :name, :description, :seo_meta, :policies, :amenities do
    validates_presence_of :name
  end

  def geo_input
    ''
  end

  def geo_input=(val)
    ''
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
