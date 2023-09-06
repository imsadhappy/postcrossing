# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  include Pagination

  PER_PAGE = 10

  def index
    @pagination, @page_list = paginate(collection: Page.all, params: page_params)
  end

  def new; end

  def create; end

  def edit; end

  def destroy; end

  def home; end

  def show
    slug = request.path[1..]
    @page = Page.find_by(slug:)
    @document_title = @page ? @page.title : t('title.pages.not_found')
    render 'pages/404', status: :not_found unless @page
  end

  private

  def page_params
    params.permit(:page).merge(per_page: PER_PAGE)
  end
end
