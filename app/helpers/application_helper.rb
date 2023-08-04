# app/helpers/application_helper.rb
module ApplicationHelper
  def home_path
    if I18n.locale != I18n.default_locale
      "/#{I18n.locale}"
    else
      root_path
    end
  end

  def alt_url_for(locale)
    url_for(locale: I18n.default_locale == locale ? nil : locale)
  end
end
