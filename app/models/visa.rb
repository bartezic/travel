class Visa < ActiveRecord::Base
  attr_accessible :description, :country_id, :visa_type_id
  belongs_to :visa_type
  belongs_to :country

  translates :description

  active_admin_translates :description do
    validates_presence_of :description
  end
end
