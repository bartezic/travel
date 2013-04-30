class Gallery < ActiveRecord::Base
  has_and_belongs_to_many :photos, :join_table => :galleries_photos
  attr_accessible :title, :photo_ids, :photos_attributes
  translates :title

  accepts_nested_attributes_for :photos

  active_admin_translates :title do
    validates_presence_of :title
  end

  extend FriendlyId
  friendly_id :title, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end

end
