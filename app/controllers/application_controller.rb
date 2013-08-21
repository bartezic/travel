class ApplicationController < ActionController::Base
  if Rails.env.production?  
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end
  
  protect_from_forgery
  before_filter :set_locale

  def set_locale
    puts "gopdksjgiojsdoigjo gfsdjkgjo[sdj"
    session['locale'] = params[:locale] if params[:locale] && [:ru, :uk].include?(params[:locale].to_sym)
    I18n.locale = (session.has_key? 'locale' || !session['locale'].empty?) ? session['locale'] : I18n.default_locale
  end

  def set_admin_locale
    I18n.locale = I18n.default_locale
  end

  private
  
  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
 
  def render_500(exception)
    logger.info exception.backtrace.join("\n")
    respond_to do |format|
      format.html { render template: 'errors/500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end
end
