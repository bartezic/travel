class StaticController < ApplicationController
  def home
    # @ukraine = Country.where(code: :ua).first
    # @regions = Region.where('country_id != ?', @ukraine.id).order('id DESC').limit(5) 

    regions = popular_regions

    @regions = regions.sort_by(&:last).map(&:first).uniq.last(5)
    @countries = popular_countries(regions).sort_by(&:last).map(&:first).uniq.last(4)

    @tours = Tour.search(params).limit(5)
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

  def error
    respond_to do |format|
      format.html { render template: 'errors/404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  private
  # returned array of Hash in format { region => tours_count }
  def popular_regions
    # res =TourProgram.all.group_by(&:region_ids).inject({}){ |mem, (k,v)| k.each{|i| mem[i] = v.uniq.size; }; mem}
    # res = TourProgram.all.group_by(&:region_ids).inject({}){ |mem, i| i}
    # res.each{ |k,v| k.each{|i| res2[i] = v.uniq.size}}
    res = {}
    TourProgram.all.group_by(&:region_ids).each{ |k,v| k.each{|i| res[i] = v.uniq.size}}
    Region.find(res.map(&:first)).inject({}){ |mem, region| 
      mem[region] = res[region.id] 
      mem 
    }
  end

  # regions it is array of hash of popular regions in format { region => tours_count }
  def popular_countries(regions)
    Country.includes(:regions).where('regions.id IN (?)', regions.map(&:first).map(&:id)).inject({}){|hash, country|
      hash[country] = country.regions.inject(0){ |mem, region| mem += regions[region] }
      hash
    }
  end
end
