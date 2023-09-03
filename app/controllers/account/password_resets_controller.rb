module Account
  # app/controllers/account/password_resets_controller.rb
  class PasswordResetsController < ApplicationController
    include SessionManager

    before_action :check_session
    before_action :set_user_via_token, only: %i[edit update]

    def new; end

    def edit; end

    def create
      if (@user = User.find_by(email: params[:email]))
        UserMailer.with(user: @user).password_reset.deliver_later
        redirect_to sign_in_path, notice: t('notice.password.reset.instructions_sent')
      else
        redirect_to new_account_password_reset_path, alert: t('alert.password.email_not_registered')
      end
    end

    def update
      if @user.update(user_params)
        @user.password_reset_tokens.delete_all
        redirect_to sign_in_path, notice: t('notice.password.reset.successful')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def check_session
      redirect_to account_path if @session
    end

    def set_user_via_token
      token = PasswordResetToken.find_signed!(params[:sid])
      @user = token.user
    rescue StandardError
      redirect_to new_account_password_reset_path, alert: t('alert.password.reset_link_invalid')
    end

    def user_params
      params.permit(:password, :password_confirmation)
    end
  end
end
