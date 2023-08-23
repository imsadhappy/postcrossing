# app/controllers/registrations_controller.rb
class RegistrationsController < ApplicationController
  include SessionManager

  skip_before_action :authenticate

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_session
      UserMailer.with(user: @user).email_verification.deliver_later
      redirect_to account_detail_path, notice: t('notice.registration_successful')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
