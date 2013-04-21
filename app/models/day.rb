class Day < ActiveRecord::Base
  has_and_belongs_to_many :tours, :join_table => :tours_days

  attr_accessible :day_of_life
end
