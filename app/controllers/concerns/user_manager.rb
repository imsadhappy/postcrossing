# app/controllers/concerns/user_manager.rb
module UserManager
  extend ActiveSupport::Concern

  included do
    before_action :set_user
  end

  private

  def set_user
    @user = Current.user
    redirect_to sign_in_path unless @user
  end
end
