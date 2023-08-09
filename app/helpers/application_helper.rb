# app/helpers/application_helper.rb
module ApplicationHelper
  def current_locale
    preferred_locale = cookies[:preferred_locale]
    current_locale = params[:locale] || I18n.default_locale
    preferred_locale && preferred_locale != current_locale.to_s ? preferred_locale : current_locale
  end

  def preferred_locale
    preferred_locale = params[:preferred_locale]
    return unless preferred_locale

    cookies.permanent[:preferred_locale] = preferred_locale
    preferred_locale
  end

  def session_record(id)
    cookies.signed.permanent[:session_id] = { value: id, httponly: true }
  end
end
