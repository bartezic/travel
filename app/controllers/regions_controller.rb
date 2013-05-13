class RegionsController < InheritedResources::Base
  def show
    @region = Region.find(params[:id])
    @tours = Tour.search(params.merge({ region: @region.id }))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @region }
    end
  end
end
