module Account
  # app/controllers/user/details_controller.rb
  class DetailsController < ApplicationController
    before_action :set_user

    def show; end

    def edit; end

    def update
      if @user.update(email: params[:email])
        redirect_to_root
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      cookies.delete :uid
      redirect_to root_path, notice: t('notice.account_deleted')
    end

    private

    def set_user
      @user = Current.user
      redirect_to sign_in_path unless @user
    end
  end
end
