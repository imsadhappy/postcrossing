# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  include UserManager
  include Pagination

  before_action :authorize

  def index; end

  def new; end

  def create; end

  def edit; end

  def destroy; end

  private

  def authorize
    redirect_to sign_in_path unless @user
    redirect_to account_path unless @user.admin?
  end

  def paginated_collection
    Page.all
  end

  def pagination_settings
    params.permit(:page).merge(per_page: 3)
  end
end
