class Galery < ActiveRecord::Base
  has_many :photos
  attr_accessible :title

  active_admin_translates :title do
    validates_presence_of :title
  end
end
