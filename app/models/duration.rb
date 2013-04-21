class Duration < ActiveRecord::Base
  has_and_belongs_to_many :tours, :join_table => :tours_durations
  attr_accessible :count_of_night
end
