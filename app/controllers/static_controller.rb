class StaticController < ApplicationController
  def home
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
