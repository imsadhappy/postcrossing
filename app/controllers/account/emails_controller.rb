module Account
  # app/controllers/account/emails_controller.rb
  class EmailsController < ApplicationController
    include UserManager

    def edit; end

    def update
      if !@user.authenticate(params[:current_password])
        redirect_to edit_account_email_path, alert: t('alert.password.incorrect')
      elsif @user.update(email: params[:email])
        redirect_on_update
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def check_user
      redirect_to sign_in_path unless @user
    end

    def redirect_on_update
      notice = t('notice.email_changed')
      if @user.email_previously_changed?
        UserMailer.with(user: @user).email_verification.deliver_later
        notice << '. ' << t('notice.email_verification.pending')
      end
      redirect_to account_path, notice:
    end
  end
end
