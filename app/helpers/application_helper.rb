# app/helpers/application_helper.rb
module ApplicationHelper
  def current_locale
    preferred_locale = cookies[:preferred_locale]
    locale = params[:locale] || I18n.default_locale
    preferred_locale && preferred_locale != locale.to_s ? preferred_locale : locale
  end

  def preferred_locale
    preferred_locale = params[:preferred_locale]
    return unless preferred_locale

    if preferred_locale == I18n.default_locale.to_s
      cookies.delete :preferred_locale
    else
      cookies.permanent[:preferred_locale] = preferred_locale
    end
    preferred_locale
  end

  def create_session(user)
    session = user.sessions.create!
    cookies.signed.permanent[:uid] = { value: session.id, httponly: true }
    session
  end
end
