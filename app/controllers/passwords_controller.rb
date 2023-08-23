# app/controllers/passwords_controller.rb
class PasswordsController < ApplicationController
  include UserManager

  def edit; end

  def update
    if !@user.authenticate(params[:current_password])
      redirect_to edit_password_path, alert: t('alert.password.current_incorrect')
    elsif @user.update(user_params)
      redirect_to account_detail_path, notice: t('notice.password.changed')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:password, :password_confirmation)
  end
end
