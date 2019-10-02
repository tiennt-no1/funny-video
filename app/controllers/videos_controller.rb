class VideosController < ApplicationController
  before_action :authorize_request

  def index
    @videos = Video.all
  end

  def create

    video = Video.create!(youtube_url: params.require(:youtube_url), user: @current_user)
    render json: {success: true, data: video}
  end
end
