class Video < ApplicationRecord
  validates :youtube_url, presence: true, uniqueness: false
  validate :validate_youtube_url
  belongs_to :user, foreign_key: :created_by
  has_many :votes
  before_save :format_url

  def like_by_user(user)
    user_id = user.is_a?(User) ? user.id : user
    votes.where(user_id: user_id).like.present?
  end

  def dislike_by_user(user)
    user_id = user.is_a?(User) ? user.id : user
    votes.where(user_id: user_id).dislike.present?
  end

  private
  def get_youtube_id_from_url
    if youtube_url.to_s.include? '?'
      youtube_url.to_s.split('?').last.match(/v=([A-Za-z0-9_]+)&?.*$/).try(:[],1)
    elsif youtube_url.to_s.match(/(www\.youtube\.com|youtu\.be)\/.+/)
      youtube_url.to_s.split('/').last
    end
  end

  def format_url
    self.youtube_url = "https://www.youtube.com/embed/#{get_youtube_id_from_url}"
  end

  def validate_youtube_url
    errors.add(:youtube_url, 'invalid_youtube_url') if get_youtube_id_from_url.blank?
  end


end
