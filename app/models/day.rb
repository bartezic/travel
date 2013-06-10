class Day < ActiveRecord::Base
  has_and_belongs_to_many :tours, :join_table => :tours_days

  attr_accessible :day_of_life

  after_destroy :deactivate_all_without_days

  private

  def deactivate_all_without_days
    Tour.includes(:days).where(active: true).each{ |tour| tour.update_attributes(active: false) if tour.days.count == 0 }
  end
end
