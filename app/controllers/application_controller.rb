# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :current_details
  before_action :authenticate
  before_action :prefered_locale
  around_action :current_locale

  private

  def current_locale(&)
    I18n.with_locale(helpers.current_locale, &)
  end

  def prefered_locale
    redirect_to request.path if helpers.preferred_locale
  end

  def authenticate
    session_id = cookies.signed[:session_id]
    session_record = Session.find_by_id(session_id)
    if session_record
      Current.session = session_record
    else
      cookies.delete :session_id
    end
  end

  def current_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end
end
