# app/controllers/concerns/session_manager.rb
module SessionManager
  extend ActiveSupport::Concern

  def current_session
    @session = Session.find_by_id(cookies.signed[:postcrossing_user])
    end_session unless @session
  end

  def start_session
    @session = @user.sessions.create!
    cookies.signed.permanent[:postcrossing_user] = {
      value: @session.id,
      httponly: true
    }
  end

  def end_session
    cookies.delete :postcrossing_user
  end

  def daily_visit
    return unless @session
    return if cookies[:postcrossing_visit]

    today = Date.today
    Current.user.update(last_seen: today) unless Current.user.last_seen == today

    cookies.signed[:postcrossing_visit] = {
      value: today.to_time(:utc),
      httponly: true,
      expires: Date.tomorrow.to_time(:utc)
    }
  end
end
