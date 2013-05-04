class StaticController < ApplicationController
  def home
    # @ukraine = Country.where(code: :ua).first
    # @regions = Region.where('country_id != ?', @ukraine.id).order('id DESC').limit(5) 

    res = TourProgram.all.group_by(&:region_ids)
    res2 = {}
    res.each{ |k,v| k.each{|i| res2[i] = v.uniq.size}}
    res2 = res2.sort_by(&:last).map(&:first).uniq.last(5)
    @regions = Region.find(res2)

    @tours = Tour.includes(:tour_programs).order('id DESC').limit(5);
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
end
