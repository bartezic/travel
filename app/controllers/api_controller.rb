class ApiController < ApplicationController
  def geocode
    query = "http://maps.googleapis.com/maps/api/geocode/json?address=#{CGI.escape(params[:query])}&sensor=true&language=uk"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: open(query).read }
    end
  end

  def photos
    @res = Photo.where("photos.title ilike ?", "%#{params[:query]}%").with_translations(I18n.locale).sort_by(&:title).map{ |photo|
      { text: photo.title, id: photo.id, thumb: photo.asset(:thumb_150x) }
    }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @res.to_json }
    end
  end

  def tags
    @res = Tag.where("tags.title ilike ?", "%#{params[:query]}%").with_translations(I18n.locale).sort_by(&:title).map{ |tag|
      { text: tag.title, id: tag.id }
    }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @res.to_json }
    end
  end
end
