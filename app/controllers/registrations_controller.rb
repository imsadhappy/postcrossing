# app/controllers/registrations_controller.rb
class RegistrationsController < ApplicationController
  include SessionManager

  before_action :check_session

  def new
    @user = User.new
  end

  def create
    @user = User.new(permitted_params)
    if @user.save
      start_session(@user)
      UserMailer.with(user: @user).email_verification.deliver_later
      redirect_to account_detail_path, notice: t('notice.registration_successful')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def check_session
    redirect_to account_detail_path if @session
  end

  def permitted_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
