class StaticController < ApplicationController
  def home
    # @ukraine = Country.where(code: :ua).first
    # @regions = Region.where('country_id != ?', @ukraine.id).order('id DESC').limit(5) 

    @regions = popular_regions
    @countries = popular_countries
    @tours = Tour.search(params).limit(6)
    @hot_tours2 = HotTours.where(active: true).with_translations(I18n.locale).limit(6)
    @hot_tours = Tour.search(params.merge({ tour_type: TourType.where(code: :hot).map(&:id) }))
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {} }
    end
  end
  
  def contacts
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {} }
    end
  end

  def visas
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {} }
    end
  end

  def hot_tours
    @hot_tours = HotTours.where(active: true).with_translations(I18n.locale)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hot_tours }
    end
  end

  def error
    respond_to do |format|
      format.html { render template: 'errors/404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  private
  # returned array of Hash in format { region => tours_count }
  def popular_regions
    Region.includes(:tour_programs).inject({}){|mem, region| 
      mem[region] = region.tour_programs.map(&:tour_id).uniq.size; 
      mem
    }.sort_by(&:last).map(&:first).uniq.last(6).reverse
  end

  # regions it is array of hash of popular regions in format { region => tours_count }
  def popular_countries
    Country.includes(:regions, :regions => :tour_programs).inject({}){|mem, country|
      mem[country] = country.regions.map{ |region| region.tour_programs.map(&:tour_id) }.flatten.uniq.size
      mem
    }.sort_by(&:last).map(&:first).uniq.last(6).reverse
  end
end
