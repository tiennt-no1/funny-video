class VideosController < ApplicationController
  before_action :authorize_request
  before_action :find_video, only: %i[like dislike]
  before_action :remove_all_votes, only: %i[like dislike]

  def index
    @videos = Video.all.order(:created_at)
  end

  def like
    vote = @current_user.votes.create(video: @video)
    render json: {success: true, data: vote}
  end

  def dislike
    @current_user.votes.delete_all
    vote = @current_user.votes.create(video: @video, like: false)
    render json: {success: true, data: vote}
  end

  def create
    video = Video.create!(youtube_url: params.require(:youtube_url), user: @current_user)
    render json: {success: true, data: video}
  end

  private

  def remove_all_votes
    @current_user.votes.where(video_id: params[:id]).delete_all
  end

  def find_video
    @video = Video.find(params[:id])
  end
end
