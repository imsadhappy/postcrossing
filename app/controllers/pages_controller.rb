# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def home; end

  def show
    slug = request.path[1..]
    @page = Page.find_by(slug:)
    @document_title = @page ? @page.title : t('title.pages.not_found')
    if @page
      render text: @page.body
    else
      render 'pages/404', status: :not_found
    end
  end
end
