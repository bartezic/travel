class Country < ActiveRecord::Base
  has_and_belongs_to_many :continents, :join_table => :continents_countries
  belongs_to :photo
  has_many :regions
  has_one :visa
  
  translates :name, :description, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure
  attr_accessible :continent_ids, :photo_id, :name, :description, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure, :code

  active_admin_translates :name, :description, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure do
    validates_presence_of :name
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
