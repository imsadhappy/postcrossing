# app/controllers/concerns/locale_manager.rb
module LocaleManager
  extend ActiveSupport::Concern

  included do
    before_action :change_locale
    around_action :set_locale
  end

  def set_locale(&)
    I18n.with_locale(current_locale, &)
  end

  def change_locale
    redirect_to request.path if update_locale
  end

  private

  def current_locale
    cookie_locale = cookies[:postcrossing_locale]
    locale = params[:locale] || I18n.default_locale
    cookie_locale && cookie_locale != locale.to_s ? cookie_locale : locale
  end

  def update_locale
    locale = params[:hl]
    return false unless locale

    if locale == I18n.default_locale.to_s
      cookies.delete :postcrossing_locale
    else
      cookies.permanent[:postcrossing_locale] = locale
    end
    locale
  end
end
