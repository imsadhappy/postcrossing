module Account
  # app/controllers/user/details_controller.rb
  class DetailsController < ApplicationController
    include SessionManager
    include UserManager

    def show; end

    def edit; end

    def update
      if @user.update(about: strip_tags(params[:about]))
        redirect_to account_detail_path, notice: t('notice.changes_saved')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      end_session
      redirect_to root_path, notice: t('notice.account_deleted')
    end

    private

    def strip_tags(string)
      ActionView::Base.full_sanitizer.sanitize(string)
    end
  end
end
