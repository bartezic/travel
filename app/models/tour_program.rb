class TourProgram < ActiveRecord::Base
  # default_scope :order => 'CAST(day_number AS INTEGER) ASC'
  default_scope :order => 'id ASC'

  belongs_to :tour
  has_and_belongs_to_many :regions, :join_table => :tour_programs_regions
  
  translates :description
  attr_accessible :day_number, :description, :tour_id, :region_ids

  active_admin_translates :description
end
