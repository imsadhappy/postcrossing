# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def after_sign_in_path_for(_request)
    edit_user_registration_path
  end

  def after_sign_out_path_for(_request)
    new_user_session_path
  end
end
