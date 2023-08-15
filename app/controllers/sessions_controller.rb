# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]

  before_action :set_session, only: :destroy

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      @session = helpers.create_session(user)
      redirect_to account_detail_path, notice: t('notice.session_created')
    else
      redirect_to sign_in_path(email_hint: params[:email]), alert: t('alert.invalid_sign_in')
    end
  end

  def destroy
    @session.destroy
    redirect_to account_detail_path, notice: t('notice.session_destroyed')
  end

  private

  def set_session
    @session = Current.user.sessions.find(params[:id])
  end
end
