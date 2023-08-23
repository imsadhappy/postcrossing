# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    @stats = {
      registrations: {
        today: Stats::Registrations.for_day,
        this_month: Stats::Registrations.for_month
      },
      visits: {
        today: Stats::Visits.for_day,
        this_month: Stats::Visits.for_month
      }
    }
  end
end
