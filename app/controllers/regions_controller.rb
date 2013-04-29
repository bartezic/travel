class RegionsController < InheritedResources::Base
  def show
    @region = Region.find(params[:id])
    @tours = Tour.find(@region.tour_programs.map(&:tour_id))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @region }
    end
  end
end
