class CountriesController < InheritedResources::Base
  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
    @country = Country.includes(:regions).find(params[:id])
    @tours = Tour.find(@country.regions.includes(&:tour_programs).map{ |i| i.tour_programs.map(&:tour_id) }.flatten)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country }
    end
  end
end
