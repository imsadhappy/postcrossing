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
    session_id = cookies.signed[:postcrossing_user]
    return unless session_id

    @session = cached_session session_id
    Current.session = @session
    end_session unless @session
  end

  def start_session(user)
    @session = user.sessions.create!
    Current.session = @session
    RedisStorage.set "session_#{@session.id}", @session.to_json, 24.hours
    cookies.signed.permanent[:postcrossing_user] = {
      value: @session.id,
      httponly: true
    }
  end

  def end_session(session_id = nil)
    return unless @user&.sessions

    session_id ||= @user.sessions.first.id
    RedisStorage.del "session_#{session_id}"
    @user.sessions.find(session_id).destroy

    return unless session_id.to_i == cookies.signed[:postcrossing_user].to_i

    cookies.delete :postcrossing_user
    cookies.delete :postcrossing_visit
  end

  private

  def cached_session(session_id)
    json_session = RedisStorage.fetch "session_#{session_id}", 24.hours do
      Session.find_by_id(session_id).to_json
    end

    return if json_session == 'null'

    session = Session.new.from_json json_session

    return unless session.user_agent == request.user_agent && session.ip_address == request.ip

    session
  end
end
