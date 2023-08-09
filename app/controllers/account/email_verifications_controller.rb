module Account
  # app/controllers/user/email_verifications_controller.rb
  class EmailVerificationsController < ApplicationController
    skip_before_action :authenticate, only: :show
    before_action :set_user, only: :show

    def show
      @user.update! verified: true
      redirect_to account_detail_path, notice: 'Thank you for verifying your email address'
    end

    def create
      send_email_verification
      redirect_to account_detail_path, notice: 'We sent a verification email to your email address'
    end

    private

    def set_user
      token = EmailVerificationToken.find_signed!(params[:sid])
      @user = token.user
    rescue StandardError
      redirect_to edit_account_email_path, alert: 'That email verification link is invalid'
    end

    def send_email_verification
      UserMailer.with(user: Current.user).email_verification.deliver_later
    end
  end
end
