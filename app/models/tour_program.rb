class TourProgram < ActiveRecord::Base
  belongs_to :tour
  has_and_belongs_to_many :regions, :join_table => :tour_programs_regions
  
  translates :description
  attr_accessible :day_number, :description, :tour_id

  active_admin_translates :description
end
