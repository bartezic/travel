class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
 
  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  def set_locale
    session['locale'] = params[:locale] if params[:locale]
    I18n.locale = (session.has_key? 'locale' || !session['locale'].empty?) ? session['locale'] : I18n.default_locale
  end

  # def set_admin_locale
  #   I18n.locale = :en
  # end
end
