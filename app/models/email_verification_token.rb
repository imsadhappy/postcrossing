# app/models/email_verification_token.rb
class EmailVerificationToken < ApplicationRecord
  belongs_to :user
end
