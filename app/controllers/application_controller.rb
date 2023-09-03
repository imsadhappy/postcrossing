# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include LocaleManager

  rescue_from Redis::CannotConnectError do |err|
    helpers.log err.message
    render inline: File.read('public/500.html'), status: 500
  end
end
