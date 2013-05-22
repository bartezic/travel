class Duration < ActiveRecord::Base
  default_scope :order => 'durations.count_of_night ASC'
  has_and_belongs_to_many :tours, :join_table => :tours_durations
  attr_accessible :count_of_night
end
