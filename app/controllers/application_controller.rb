# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :authenticate
  before_action :save_prefered_locale
  around_action :set_locale

  def set_locale(&)
    preferred_locale = cookies[:preferred_locale]
    current_locale = params[:locale] || I18n.default_locale
    locale = preferred_locale && preferred_locale != current_locale.to_s ? preferred_locale : current_locale

    I18n.with_locale(locale, &)
  end

  private

  def save_prefered_locale
    preferred_locale = params[:preferred_locale]

    return unless preferred_locale

    cookies.permanent[:preferred_locale] = preferred_locale
    redirect_to request.path
  end

  def authenticate
    session_record = Session.find_by_id(cookies.signed[:session_token])
    return unless session_record

    Current.session = session_record
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end
end
