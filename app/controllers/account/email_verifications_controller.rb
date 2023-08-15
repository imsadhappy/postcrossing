module Account
  # app/controllers/user/email_verifications_controller.rb
  class EmailVerificationsController < ApplicationController
    skip_before_action :authenticate, only: :show
    before_action :set_user, only: :show

    def show
      @user.update! verified: true
      redirect_to account_detail_path, notice: t('notice.email_verification.show')
    end

    def create
      UserMailer.with(user: Current.user).email_verification.deliver_later
      redirect_to account_detail_path, notice: t('notice.email_verification.create')
    end

    private

    def set_user
      token = EmailVerificationToken.find_signed!(params[:sid])
      @user = token.user
    rescue StandardError
      redirect_to edit_account_email_path, alert: t('notice.email_verification.invalid')
    end
  end
end
