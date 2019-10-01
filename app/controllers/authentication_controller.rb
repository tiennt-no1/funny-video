class AuthenticationController < ApplicationController

  def new_session;
  end

  def login
    @current_user = User.find_by!(username: params[:username])
    if @current_user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @current_user.id)
      @current_user.tokens.create!(token: token)
      time = Time.now + 24.hours.to_i
      respond_to do |format|
        format.json do
          return render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                                    username: @current_user.username}, status: :ok

        end
        format.any do
          response.headers["Authorization"] = "Bearer #{token}"
          render 'videos/index'
        end
      end
    else
      respond_to do |format|
        format.json { return render json: {error: 'unauthorized'}, status: :unauthorized }
        format.any { redirect_to auth_new_path }
      end
    end
  end

  def logout
    Token.find_by!(token: authorize_header).delete
    render json: {message: 'success'}, status: :ok
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end
