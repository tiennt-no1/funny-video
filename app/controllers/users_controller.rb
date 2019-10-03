class UsersController < ApplicationController
  before_action :authorize_request, except: %i[new create]
  before_action :find_user, only: %i[show index]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to auth_new_path
    else
      render json: {errors: @user.errors.full_messages},
             status: :unprocessable_entity
    end
  end

  def update
    unless @user.update(user_params)
      render json: {errors: @user.errors.full_messages},
             status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by!(username: params.require(:username))
  rescue ActiveRecord::RecordNotFound
    render json: {errors: 'User not found'}, status: :not_found
  end

  def user_params
    params.require(:user).permit(
        :username, :password, :password_confirmation
    )
  end
end
