module Account
  # app/controllers/user/details_controller.rb
  class DetailsController < ApplicationController
    before_action :set_user

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
      redirect_to root_path, notice: 'Your account has been deleted'
    end

    private

    def set_user
      @user = Current.user
    end
  end
end
