# app/controllers/concerns/session_manager.rb
module SessionManager
  extend ActiveSupport::Concern

  included do
    before_action :set_request
    before_action :set_session
  end

  def set_request
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end

  def set_session
    @session = Session.find_by_id(cookies.signed[:postcrossing_user])
    Current.session = @session
    end_session unless @session
  end

  def start_session(user)
    @session = user.sessions.create!
    Current.session = @session
    cookies.signed.permanent[:postcrossing_user] = {
      value: @session.id,
      httponly: true
    }
  end

  def end_session(session_id = nil)
    return unless @user&.sessions

    (session_id ? @user.sessions.find(session_id) : @user.sessions.first).destroy

    return unless @user.sessions.empty?

    cookies.delete :postcrossing_user
    cookies.delete :postcrossing_visit
  end
end
