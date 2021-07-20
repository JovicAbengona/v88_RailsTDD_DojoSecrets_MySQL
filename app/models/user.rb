class User < ApplicationRecord
  has_secure_password

  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  # Validation for length is not working because it is already encrypted before being validated. Solved it by validating in manually
  validates :password_digest, presence: true, confirmation: { case_sensitive: true }

  # this callback will run before saving on create and update
  before_save :downcase_email

  private
      def downcase_email
          self.email.downcase!
      end
end