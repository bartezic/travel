class ContinentsController < InheritedResources::Base
  def index
    @continents = Continent.with_translations(locale)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @continents }
    end
  end
end
