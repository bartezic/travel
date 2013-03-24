class Region < ActiveRecord::Base
  belongs_to :galery
  belongs_to :country
  has_many :attractions
  has_many :hotels
  attr_accessible :country_id, :description, :galery_id, :name, :meta_description
  translates :name, :description, :meta_description

  active_admin_translates :name, :description, :meta_description do
    validates_presence_of :name
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end

end
