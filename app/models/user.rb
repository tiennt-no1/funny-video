class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :username, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  has_many :videos, foreign_key: :created_by
  has_many :tokens
  has_many :votes
end
