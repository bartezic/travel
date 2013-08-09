class ToursController < InheritedResources::Base
  def show
    @tour = Tour.find(params[:id])
    regions_ids = Country.joins(:regions).where('regions.id in (?)', @tour.tour_programs.map(&:region_ids).flatten).map(&:region_ids).flatten
    @related = Tour.search(params.merge({ region: regions_ids, tour_typ: @tour.tour_types.map(&:id) })).where('tours.id != ?', @tour.id).limit(12)
  end

  def index
    @tours = Tour.search(params)
  end
end
