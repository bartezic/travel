class VisaType < ActiveRecord::Base
  attr_accessible :title
  has_many :visas

  translates :title

  active_admin_translates :title do
    validates_presence_of :title
  end
end
