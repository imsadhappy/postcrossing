# app/controllers/confirmations_controller.rb
class ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(_resource_name, resource)
    sign_in(resource)
    edit_user_registration_path
  end
end
