class StaticController < ApplicationController
  def home
    @ukraine = Country.where(code: :ua).first
    @regions = Region.where('country_id != ?', @ukraine.id).order('id DESC').limit(5)  
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
