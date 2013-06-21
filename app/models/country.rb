class Country < ActiveRecord::Base
  extend FriendlyId

  default_scope :order => 'countries.name ASC'
  
  belongs_to :photo
  has_many :regions
  has_one :visa
  has_and_belongs_to_many :continents,  :join_table => :continents_countries
  has_and_belongs_to_many :keywords,    :join_table => :countries_keywords
  
  attr_accessible :id, :continent_ids, :photo_id, :name, :description, :seo_meta, :kitchen, 
                  :recomendation, :climate, :culture, :infrastructure, :code, :keyword_ids, 
                  :keywords_attributes

  accepts_nested_attributes_for :keywords
  
  friendly_id :name, use: :slugged

  translates :name, :description, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure
  active_admin_translates :name, :description, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure do
    validates_presence_of :name
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
