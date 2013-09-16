class HotTours < ActiveRecord::Base
  default_scope :order => 'hot_tours.id DESC'

  belongs_to :photo
  attr_accessible :photo_id, :description, :title, :active

  translates  :title, :description
  active_admin_translates :title, :description do
    validates_presence_of :title, :description
  end
end
