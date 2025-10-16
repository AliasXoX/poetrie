class SessionsController < ApplicationController
  skip_before_action :user_signed_in?, only: [ :new, :create ]
  skip_before_action :still_authenticated?, only: [ :new, :create ]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      log_in(@user)
      redirect_to root_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid username or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully."
  end
end
