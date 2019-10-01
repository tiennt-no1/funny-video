class Video < ApplicationRecord
  has_secure_password
  validates :youtube_url, presence: true, uniqueness: false
  belongs_to :user, foreign_key: :created_by
end
