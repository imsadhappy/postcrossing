# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery
  around_action :switch_locale

  def switch_locale(&action)
    I18n.with_locale(params[:locale] || I18n.default_locale, &action)
  end
end
