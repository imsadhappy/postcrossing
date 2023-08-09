module Sessions
  # app/controllers/sessions/omniauth_controller.rb
  class OmniauthController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate

    def create
      @user = User.create_with(user_params).find_or_initialize_by(omniauth_params)

      if @user.save
        session_record = @user.sessions.create!
        helpers.session_record session_record.id
        redirect_to account_detail_path, notice: 'Signed in successfully'
      else
        redirect_to sign_in_path, alert: 'Authentication failed'
      end
    end

    def failure
      redirect_to sign_in_path, alert: params[:message]
    end

    private

    def user_params
      { email: omniauth.info.email, password: SecureRandom.base58, verified: true }
    end

    def omniauth_params
      { provider: omniauth.provider, uid: omniauth.uid }
    end

    def omniauth
      request.env['omniauth.auth']
    end
  end
end
