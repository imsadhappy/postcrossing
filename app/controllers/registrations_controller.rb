# app/controllers/registrations_controller.rb
class RegistrationsController < ApplicationController
  include SessionManager

  before_action :check_session
  before_action :match_passwords, only: :create

  def new
    @user = User.new
  end

  def create
    if User.find_by(email: params[:email])
      redirect_to sign_in_path, alert: t('alert.already_registered')
    else
      @user = User.new(filtered_params)
      if @user.save
        start_session
        UserMailer.with(user: @user).email_verification.deliver_later
        redirect_to account_path, notice: t('notice.registration_successful')
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def match_passwords
    return if params[:password] == params[:password_confirmation]

    redirect_to sign_up_path(email: params[:email], name: params[:name]), alert: t('alert.password.dont_match')
  end

  def check_session
    redirect_to account_path if @session
  end

  def permitted_params
    params.permit :name, :email, :password, :password_confirmation, :authenticity_token, :commit
  end

  def filtered_params
    permitted_params.slice 'name', 'email', 'password'
  end
end
