class ApplicationController < ActionController::Base

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_header
    header = request.headers['Authorization']
    return '' unless  header
    header.split(' ').last
  end

  def authorize_request
    token = authorize_header
    begin
      Token.find_by!(token: token)
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to new_user_path
    rescue JWT::DecodeError => e
      redirect_to new_user_path
    end
  end
end
