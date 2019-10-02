class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  def not_found
    render json: {error: 'not_found'}
  end

  def authorize_token
    header = request.headers['Authorization']
    header.to_s.split(' ').last || cookies['access-token']
  end

  def authorize_request
    token = authorize_token
    begin
      Token.find_by!(token: token)
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.html { return redirect_to auth_new_path }
        format.any { render json: {error: 'not_found'}, status: :unauthorized }
      end
    rescue JWT::DecodeError => e
      respond_to do |format|
        format.html { return redirect_to auth_new_path }
        format.any { render json: {error: 'invalid_token', status: :unauthorized} }
      end
    end
  end
end
