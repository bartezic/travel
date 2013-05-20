class StaticController < ApplicationController
  def home
    # @ukraine = Country.where(code: :ua).first
    # @regions = Region.where('country_id != ?', @ukraine.id).order('id DESC').limit(5) 

    res = TourProgram.all.group_by(&:region_ids)
    res2 = {}
    res.each{ |k,v| k.each{|i| res2[i] = v.uniq.size}}
    res2 = res2.sort_by(&:last).map(&:first).uniq.last(5)
    @regions = Region.find(res2)
    @countries = Country.limit(4)

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
end
