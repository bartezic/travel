class Continent < ActiveRecord::Base
  has_many :countries
  
  translates :description, :name
  attr_accessible :description, :name

  active_admin_translates :name, :description do
    validates_presence_of :name
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
