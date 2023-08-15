# app/models/password_reset_token.rb
class PasswordResetToken < ApplicationRecord
  belongs_to :user
end
