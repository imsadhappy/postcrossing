# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include SessionManager
  include LocaleManager

  before_action :authenticate

  private

  def authenticate
    current_session
    Current.session = @session if @session
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
    daily_visit
  end
end
