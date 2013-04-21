class Tour < ActiveRecord::Base
  belongs_to :currency
  belongs_to :photo
  has_and_belongs_to_many :days, :join_table => :tours_days
  has_and_belongs_to_many :durations, :join_table => :tours_durations
  has_and_belongs_to_many :food_types, :join_table => :tours_food_types
  has_and_belongs_to_many :tour_types, :join_table => :tours_tour_types
  has_and_belongs_to_many :transports, :join_table => :tours_transports
  has_and_belongs_to_many :regions, :join_table => :tours_regions

  translates  :title, :description, :transport_description, :price_list, :price_included, :price_excluded, 
              :note, :excursions, :seo_meta
  attr_accessible :day_ids, :tour_type_ids, :food_type_ids, :duration_ids, :transport_ids, :region_ids, 
                  :currency_id, :photo_id, :price_from, :price_to, :active, :title, :description, 
                  :transport_description, :price_list, :price_included, :price_excluded, :note, :excursions, :seo_meta

  active_admin_translates :title, :description, :transport_description, :price_list, :price_included, :price_excluded, :note, :excursions, :seo_meta do
    validates_presence_of :title
  end

  extend FriendlyId
  friendly_id :title, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end


