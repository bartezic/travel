class StaticController < ApplicationController
  def home
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {} }
    end
  end
end
