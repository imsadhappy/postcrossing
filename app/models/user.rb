# app/models/user.rb
class User < ApplicationRecord
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

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  # groups

  def admin?
    is 'admin'
  end

  def is(group)
    in_group "#{group}s"
  end

  def in_group(group)
    groups.split(',').include? group.to_s.downcase
  end

  def add_to(group)
    group = group.to_s.downcase
    return false if in_group group

    self.groups += ",#{group}"
    save
  end

  def remove_from(group)
    group = group.to_s.downcase
    return false if group == 'users'

    groups = self.groups.split(',')
    return false unless groups.include? group

    groups.delete(group)
    self.groups = groups.join(',')
    save
  end
end
