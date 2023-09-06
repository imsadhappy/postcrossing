module Account
  # app/controllers/account/details_controller.rb
  class DetailsController < ApplicationController
    include UserManager

    before_action :check_user

    def show; end

    def edit
      @field_name = request.path.split('/')[2]
      redirect_to account_path unless @user.has_attribute?(@field_name)
      @document_title = t("title.#{@field_name}.#{action_name}")
      @field_value = @user.instance_eval(@field_name)
    end

    def update
      if @user.update(user_params)
        redirect_to account_path, notice: t('notice.changes_saved')
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

    def check_user
      redirect_to sign_in_path unless @user
    end

    def strip_tags(string)
      ActionView::Base.full_sanitizer.sanitize(string)
    end

    def user_params
      params.permit(:about, :address)
    end
  end
end
