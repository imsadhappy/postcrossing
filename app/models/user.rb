# app/models/user.rb
class User < ApplicationRecord
  include UserGroups

  has_secure_password

  has_many :email_verification_tokens, dependent: :destroy
  has_many :password_reset_tokens, dependent: :destroy
  has_many :sessions, dependent: :destroy

  validates :name, presence: true, allow_nil: false
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }

  before_validation if: -> { email.present? } do
    self.email = email.downcase.strip
  end

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  before_validation if: :last_seen_changed?, on: :update do
    record_visit_stats
  end

  before_create do
    self.last_seen = DateTime.now
  end

  after_create do
    record_visit_stats
    record_registration_stats
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  private

  def record_visit_stats
    Stats::Visits.record
  end

  def record_registration_stats
    Stats::Registrations.record
  end
end
