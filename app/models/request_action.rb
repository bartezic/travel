class RequestAction < ActiveRecord::Base
  belongs_to :currency
  has_and_belongs_to_many :tour_types, :join_table => :request_actions_tour_types
  has_and_belongs_to_many :transports, :join_table => :request_actions_transports
   
  attr_accessible :adults, :budget, :childrens, :countries, :currency_id, :departure_date, :duration, 
                  :email, :name, :node, :phone, :response_type, :subscribe, :tour_type_ids, :transport_ids
end
