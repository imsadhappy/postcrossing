module Account
  # app/controllers/user/email_verifications_controller.rb
  class EmailVerificationsController < ApplicationController
    include UserManager

    skip_before_action :set_user, only: :show
    before_action :set_user_via_token, only: :show

    def show
      @user.update! verified: true
      start_session(@user)
      redirect_to account_detail_path, notice: t('notice.email_verification.show')
    end

    def create
      UserMailer.with(user: @user).email_verification.deliver_later
      redirect_to account_detail_path, notice: t('notice.email_verification.create')
    end

    private

    def set_user_via_token
      token = EmailVerificationToken.find_signed!(params[:sid])
      @user = token.user
    rescue StandardError
      redirect_to account_detail_path, alert: t('notice.email_verification.invalid')
    end
  end
end
