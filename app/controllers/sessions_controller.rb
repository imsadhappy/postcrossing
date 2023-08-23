# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  include SessionManager

  skip_before_action :authenticate, only: %i[new create]
  before_action :set_user, only: %i[index destroy]
  before_action :switch_session, only: :destroy

  def index
    order_sessions
  end

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      start_session
      redirect_to account_detail_path, notice: t('notice.session_created')
    else
      redirect_to sign_in_path(email_hint: params[:email]), alert: t('alert.invalid_sign_in')
    end
  end

  def destroy
    @session.destroy
    redirect_to sessions_path, notice: t('notice.session_destroyed')
  end

  private

  def switch_session
    @session = @user.sessions.find(params[:id])
  end

  def order_sessions
    @sessions = @user.sessions.order(created_at: :desc)
  end

  def set_user
    @user = Current.user
    redirect_to sign_in_path unless @user
  end
end
