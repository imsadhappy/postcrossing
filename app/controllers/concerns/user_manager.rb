# app/controllers/concerns/user_manager.rb
module UserManager
  extend ActiveSupport::Concern

  include SessionManager

  included do
    before_action :set_user
  end

  def set_user
    @user = Current.user
    record_last_seen if @user
  end

  def record_last_seen
    return if cookies[:postcrossing_visit]

    @user.update(last_seen: Date.today) unless @user.last_seen == Date.today

    cookies.signed[:postcrossing_visit] = {
      value: Date.today.to_time(:utc),
      httponly: true,
      expires: Date.tomorrow.to_time(:utc)
    }
  end
end
