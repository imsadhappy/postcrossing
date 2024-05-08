module Sessions
  # app/controllers/sessions/omniauth_controller.rb
  class OmniauthController < ApplicationController
    include SessionManager

    skip_before_action :verify_authenticity_token

    def create
      @user = User.find_by(omniauth_params)
      if @user
        @user.update(last_seen: DateTime.now)
        start_session
        redirect_to account_path, notice: t('notice.session_created')
      else
        if User.find_by(email: omniauth.info.email)
          redirect_to sign_in_path, alert: t('alert.auth_failed')
        else
          @user = User.new(user_params.merge(omniauth_params))
          @user.save
          start_session
          redirect_to account_path, notice: t('notice.session_created')
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
