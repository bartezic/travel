class Hotel < ActiveRecord::Base
  extend FriendlyId

  belongs_to :gallery
  belongs_to :region
  has_and_belongs_to_many :keywords, :join_table => :hotels_keywords

  attr_accessible :name, :description, :seo_meta, :gallery_id, :region_id, :slug, :policies, 
                  :amenities, :star, :address, :phone, :email, :site, :keyword_ids, 
                  :keywords_attributes

  accepts_nested_attributes_for :keywords

  friendly_id :name, use: :slugged

  translates :name, :description, :seo_meta, :policies, :amenities
  active_admin_translates :name, :description, :seo_meta, :policies, :amenities do
    validates_presence_of :name
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
