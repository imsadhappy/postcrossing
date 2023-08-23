# app/controllers/concerns/locale_manager.rb
module LocaleManager
  extend ActiveSupport::Concern

  included do
    before_action :change_locale
    around_action :localize
  end

  def localize(&)
    I18n.with_locale(current_locale, &)
  end

  def change_locale
    redirect_to request.path if update_locale
  end

  private

  def current_locale
    hlocale = cookies[:hl]
    locale = params[:locale] || I18n.default_locale
    hlocale && hlocale != locale.to_s ? hlocale : locale
  end

  def update_locale
    locale = params[:hl]
    return false unless locale

    if locale == I18n.default_locale.to_s
      cookies.delete :hl
    else
      cookies.permanent[:hl] = locale
    end
    locale
  end
end
