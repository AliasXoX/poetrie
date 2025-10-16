class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "User created successfully."
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
