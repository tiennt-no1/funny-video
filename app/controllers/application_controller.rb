class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_token
    header = request.headers['Authorization']
    token = header.to_s.split(' ').last
    token ||= session['Authorization']
  end

  def authorize_request
    token = authorize_token
    begin
      Token.find_by!(token: token)
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to auth_new_path
    rescue JWT::DecodeError => e
      redirect_to auth_new_path
    end
  end
end
