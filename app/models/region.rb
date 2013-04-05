class Region < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :country
  has_many :attractions
  has_many :hotels
  attr_accessible :country_id, :description, :gallery_id, :name, :seo_meta, :recomendation, :infrastructure
  translates :name, :description, :seo_meta, :recomendation, :infrastructure

  active_admin_translates :name, :description, :recomendation, :infrastructure, :seo_meta do
    validates_presence_of :name
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end

end
