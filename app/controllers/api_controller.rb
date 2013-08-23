class ApiController < ApplicationController
  def geocode
    query = 'http://maps.googleapis.com/maps/api/geocode/json'
    res = RestClient.get(query, {
      params: {
        address: CGI.escape(params[:query]),
        sensor: true,
        language: 'uk'
      }
    })
    respond_to do |format|
      format.json { render json: res }
    end
  end

  def photos
    res = Photo.where("photos.title ilike ?", "%#{params[:query]}%").with_translations(I18n.locale).sort_by(&:title).map{ |photo|
      { text: photo.title, id: photo.id, thumb: photo.asset(:thumb_150x) }
    }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: res.to_json }
    end
  end

  def galleries
    res = Gallery.where("galleries.title ilike ?", "%#{params[:query]}%").with_translations(I18n.locale).sort_by(&:title).map{ |gallery|
      { text: gallery.title, id: gallery.id }
    }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: res.to_json }
    end
  end

  def regions
    res = Region.includes(:country).
      where("regions.name ilike ?", "%#{params[:query]}%").
      with_translations(I18n.locale).
      sort_by(&:name).map{ |region|
        { 
          text: "#{region.name}, #{region.country.name}", 
          id: region.id 
        }
    }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: res.to_json }
    end
  end

  def panoramio
    query = 'http://www.panoramio.com/map/get_panoramas.php'
    res = RestClient.get(query, {
      params: {
        set: 'public',
        from: 0,
        to: 20,
        minx: -180,
        miny: -90,
        maxx: 180,
        maxy: 90,
        size: 'original',
        mapfilter: true
      }
    })
    respond_to do |format|
      format.json { render json: res }
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
