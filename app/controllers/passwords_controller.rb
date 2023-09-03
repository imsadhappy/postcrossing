# app/controllers/passwords_controller.rb
class PasswordsController < ApplicationController
  include UserManager

  before_action :check_user

  def edit; end

  def update
    if !@user.authenticate(params[:current_password])
      redirect_to edit_password_path, alert: t('alert.password.current_incorrect')
    elsif @user.update(user_params)
      redirect_to account_path, notice: t('notice.password.changed')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def check_user
    redirect_to sign_in_path unless @user
  end

  def user_params
    params.permit(:password, :password_confirmation)
  end
end
