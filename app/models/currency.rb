class Currency < ActiveRecord::Base
  has_many :tours

  translates :title
  attr_accessible :code, :title, :symbol

  active_admin_translates :title
end
