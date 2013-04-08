class Hotel < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :region
  attr_accessible :name, :description, :seo_meta, :gallery_id, :region_id, :slug, :policies, :amenities, :star, :address, :phone, :email, :site
  translates :name, :description, :seo_meta, :policies, :amenities

  extend FriendlyId
  friendly_id :name, use: :slugged

  active_admin_translates :name, :description, :seo_meta, :policies, :amenities do
    validates_presence_of :name
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
