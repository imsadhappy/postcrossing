# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def home; end

  def show
    @page = Page.find_by(slug: request.path[1..])
    render 'pages/404', status: :not_found unless @page
  end
end
