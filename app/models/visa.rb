class Visa < ActiveRecord::Base
  attr_accessible :description, :country_ti, :visa_type_id
  has_one :country
  belongs_to :visa_type

  translates :description

  active_admin_translates :description do
    validates_presence_of :description
  end
end
