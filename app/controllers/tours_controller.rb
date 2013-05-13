class ToursController < InheritedResources::Base
  def show
    @tour = Tour.find(params[:id])
    regions_ids = @tour.tour_programs.map(&:region_ids).flatten
    related_ids = TourProgram.includes(:regions).where("regions.id IN (?)", regions_ids).map(&:tour_id).uniq
    related_ids.delete(@tour.id)
    @related = Tour.active.with_days.where('tours.id IN (?)',related_ids.shuffle).limit(5)
  end

  def index
    @tours = Tour.active.with_days.page(params[:page] || 0)
  end
end
