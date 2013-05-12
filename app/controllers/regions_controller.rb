class RegionsController < InheritedResources::Base
  def show
    @region = Region.find(params[:id])
    @tours = Tour.where('id IN (?)', @region.tour_programs.map(&:tour_id)).page(params[:page] || 0)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @region }
    end
  end
end
