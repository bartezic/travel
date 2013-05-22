class ToursController < InheritedResources::Base
  def show
    @tour = Tour.find(params[:id])
    regions_ids = @tour.tour_programs.map(&:region_ids).flatten
    @related = Tour.search(params.merge({ region: regions_ids })).where('tours.id != ?', @tour.id).limit(5)
  end

  def index
    @tours = Tour.search(params)
  end
end
