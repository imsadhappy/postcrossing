# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  include UserManager

  before_action :check_user, only: %i[index destroy]

  def index
    @session_list = @user.sessions.order(created_at: :desc)
  end

  def new
    redirect_to account_path if @user
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      start_session
      redirect_to account_path, notice: t('notice.session_created')
    else
      redirect_to sign_in_path(email_hint: params[:email]), alert: t('alert.invalid_sign_in')
    end
  end

  def destroy
    end_session(params[:id])
    redirect_to sessions_path, notice: t('notice.session_destroyed')
  end

  private

  def check_user
    redirect_to sign_in_path unless @user
  end
end
