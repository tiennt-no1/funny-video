class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :video
  scope :like, -> {where(like: true)}
  scope :dislike, -> {where(like: false)}
  validates :user_id, uniqueness: { scope: :video_id }

end
