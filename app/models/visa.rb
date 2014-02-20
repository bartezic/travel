class Visa < ActiveRecord::Base
  attr_accessible :description, :country_id, :visa_type_id, :foreign_pas, :foreign_pas_duration, :foreign_pas_additional, :service_pas, :diplomatic_pas
  belongs_to :visa_type
  belongs_to :country

  translates :description, :foreign_pas, :foreign_pas_duration, :foreign_pas_additional, :service_pas, :diplomatic_pas
  active_admin_translates :description, :foreign_pas, :foreign_pas_duration, :foreign_pas_additional, :service_pas, :diplomatic_pas 
end
