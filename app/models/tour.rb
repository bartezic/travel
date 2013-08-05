class Tour < ActiveRecord::Base
  extend FriendlyId

  PRICE_TYPES = [PERSON = 'person', ROOM = 'room']

  default_scope :order => 'tours.id DESC'
  belongs_to :currency
  belongs_to :photo
  belongs_to :gallery
  has_many :tour_programs, :dependent => :destroy
  has_and_belongs_to_many :days,        :join_table => :tours_days
  has_and_belongs_to_many :durations,   :join_table => :tours_durations
  has_and_belongs_to_many :food_types,  :join_table => :tours_food_types
  has_and_belongs_to_many :tour_types,  :join_table => :tours_tour_types
  has_and_belongs_to_many :transports,  :join_table => :tours_transports
  has_and_belongs_to_many :regions,     :join_table => :tours_regions
  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable
  
  attr_accessible :day_ids, :tour_type_ids, :food_type_ids, :duration_ids, :transport_ids, :region_ids, 
                  :currency_id, :photo_id, :gallery_id, :price_from, :price_to, :active, :title, :description, 
                  :transport_description, :price_list, :price_included, :price_excluded, :note, :excursions, 
                  :seo_meta, :departure_calendar, :tour_programs_attributes, :price_type, :tag_ids, 
                  :tags_attributes, :all_tags
  
  accepts_nested_attributes_for :tour_programs, allow_destroy: true
  accepts_nested_attributes_for :tags
  
  validates :price_type, inclusion: {in: PRICE_TYPES}

  scope :active,          where(:active => true)
  scope :with_days,       joins(:days)
  scope :with_from,       lambda { |ids| joins(:regions).where("regions.id IN (?)",           ids) unless ids.blank? }
  scope :with_transports, lambda { |ids| joins(:transports).where("transports.id IN (?)",     ids) unless ids.blank? }
  scope :with_tour_types, lambda { |ids| joins(:tour_types).where("tour_types.id IN (?)",     ids) unless ids.blank? }
  scope :with_countries,  lambda { |ids| with_regions(Region.where('country_id IN (?)', ids).map(&:id)) unless ids.blank? }
  scope :with_regions,    lambda { |ids| 
    with_ids(Region.where('id IN (?)', ids).includes(&:tour_programs).map{ |region|
      region.tour_programs.map(&:tour_id)
    }.flatten) unless ids.blank?
  }
  scope :with_ids,        lambda { |ids| where('tours.id IN (?)', ids) }
  scope :with_query,      lambda { |query| where("tours.title ilike ? or tours.description ilike ?", "%#{query}%", "%#{query}%") unless query.blank? }

  friendly_id :title, use: :slugged

  translates  :title, :description, :transport_description, :price_list, :price_included, :price_excluded, 
              :note, :excursions, :seo_meta
  active_admin_translates :title, :description, :transport_description, :price_list, :price_included, :price_excluded, :note, :excursions, :seo_meta do
    validates_presence_of :title
  end

  def all_tags
    tags.pluck(:title) + tour_programs.map(&:all_tags).flatten.uniq
  end

  def self.search(params, ids = [])
    includes(:translations, {tour_programs: {regions: :translations}}).
      active.
      with_transports(params[:transport]).
      with_tour_types(params[:tour_type]).
      with_countries(params[:country]).
      with_regions(params[:region]).
      with_query(params[:query]).
      with_from(params[:from]).
      uniq.
      page(params[:page] || 0)
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def departure_calendar
    mon = Date::MONTHNAMES.compact
    b = {}
    a = days.sort_by(&:day_of_life).map { |p| p.day_of_life }
    a.each {|i| b[i.year] = {}}
    a.each {|i| b[i.year][i.mon] = []}
    a.each {|i| b[i.year][i.mon] << i.day}
    b if b.any?
  end
end


