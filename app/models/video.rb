class Video < ApplicationRecord
  validates :youtube_url, presence: true, uniqueness: false
  belongs_to :user, foreign_key: :created_by
  has_many :votes

  before_create :format_url

  def get_youtube_id_from_url
    if youtube_url.include? '?'
      youtube_url.split('?').last.match(/v=([A-Za-z0-9]+)[&$]/)[1]
    else
      youtube_url.split('/').last
    end
  end

  def format_url
    self.youtube_url = "https://www.youtube.com/embed/#{get_youtube_id_from_url}"
  end

end
