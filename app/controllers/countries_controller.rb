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
    @tours = Tour.search(params.merge({ region: @country.region_ids}))
    @attractions = @country.regions.map { |i| i.attractions }.flatten
    @hotels = @country.regions.map { |i| i.hotels }.flatten
    @photos = @country.regions.map { |i| i.gallery.photos }.flatten.uniq

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country }
    end
  end
end
