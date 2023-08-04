# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :save_prefered_locale, :use_preferred_locale
  around_action :set_locale

  def save_prefered_locale
    preferred_locale = params[:preferred_locale]

    return unless preferred_locale

    cookies.permanent[:preferred_locale] = preferred_locale
    redirect_to request.path
  end

  def use_preferred_locale
    preferred_locale = cookies[:preferred_locale]
    current_locale = params[:locale] || I18n.default_locale

    return unless preferred_locale && preferred_locale != current_locale.to_s

    redirect_to controller: params[:controller], action: params[:action], locale: preferred_locale
  end

  def set_locale(&action)
    I18n.with_locale(params[:locale] || I18n.default_locale, &action)
  end

  def after_sign_in_path_for(_request)
    edit_user_registration_path
  end

  def after_sign_out_path_for(_request)
    new_user_session_path
  end
end
