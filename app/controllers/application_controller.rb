class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :still_authenticated?
  before_action :user_signed_in?


  private

  def still_authenticated?
    log_out if should_log_out?
  end

  def user_signed_in?
    redirect_to login_path unless logged_in?
  end
end
