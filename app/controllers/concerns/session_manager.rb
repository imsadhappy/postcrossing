# app/controllers/concerns/session_manager.rb
module SessionManager
  extend ActiveSupport::Concern

  def current_session
    @session = Session.find_by_id(cookies.signed[:uid])
    end_session unless @session
  end

  def start_session
    @session = @user.sessions.create!
    cookies.signed.permanent[:uid] = { value: @session.id, httponly: true }
  end

  def end_session
    cookies.delete :uid
  end
end
