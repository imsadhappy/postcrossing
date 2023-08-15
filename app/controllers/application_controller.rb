# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_current
  before_action :authenticate
  before_action :set_locale
  around_action :localize

  private

  def localize(&)
    I18n.with_locale(helpers.current_locale, &)
  end

  def set_locale
    redirect_to request.path if helpers.preferred_locale
  end

  def authenticate
    session_id = cookies.signed[:uid]
    return unless session_id

    session_record = Session.find_by_id(session_id)
    if session_record
      Current.session = session_record
    else
      cookies.delete :uid
    end
  end

  def set_current
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end
end
