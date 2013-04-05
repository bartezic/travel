class Gallery < ActiveRecord::Base
  has_many :photos
  attr_accessible :title
  translates :title

  active_admin_translates :title do
    validates_presence_of :title
  end

  extend FriendlyId
  friendly_id :title, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
