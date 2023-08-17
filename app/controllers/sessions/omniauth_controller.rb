module Sessions
  # app/controllers/sessions/omniauth_controller.rb
  class OmniauthController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate

    def create
      if User.exists?(email: user_params[:email])
        redirect_to sign_in_path, alert: t('alert.already_registered')
      else
        @user = User.create_with(user_params).find_or_initialize_by(omniauth_params)
        if @user.save
          helpers.create_session(@user)
          Stats::Registrations.record
          redirect_to account_detail_path, notice: t('notice.session_created')
        else
          redirect_to sign_in_path, alert: t('alert.auth_failed')
        end
      end
    end

    private

    def user_params
      {
        name: omniauth.info.name,
        email: omniauth.info.email,
        password: SecureRandom.base58,
        verified: true
      }
    end

    def omniauth_params
      {
        provider: omniauth.provider,
        uid: omniauth.uid
      }
    end

    def omniauth
      request.env['omniauth.auth']
    end
  end
end
