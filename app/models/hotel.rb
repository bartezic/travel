class Hotel < ActiveRecord::Base
  belongs_to :galery
  belongs_to :region
  attr_accessible :name, :description, :meta_description, :galery_id, :region_id, :slug
  translates :name, :description, :meta_description

  extend FriendlyId
  friendly_id :name, use: :slugged

  active_admin_translates :name, :description, :meta_description do
    validates_presence_of :name
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
