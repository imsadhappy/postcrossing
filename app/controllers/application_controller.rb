# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  def default_url_options
    { locale: I18n.locale }
  end
end
