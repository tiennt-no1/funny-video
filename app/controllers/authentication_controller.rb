class AuthenticationController < ApplicationController

  def new_session
  end

  def login
    @current_user = User.find_by!(username: params[:username])
    if @current_user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @current_user.id)
      @current_user.tokens.create!(token: token)
      time = Time.now + 24.hours.to_i
      render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                    username: @current_user.username}, status: :ok
    else
      render json: {errors: 'Unauthorized'}, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: {errors: 'Invalid username or password'}, status: :unauthorized
  end

  def logout
    Token.find_by!(token: authorize_token).delete
    render json: {message: 'success'}, status: :ok
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end
