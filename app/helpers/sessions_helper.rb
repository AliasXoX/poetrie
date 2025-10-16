module SessionsHelper
  def current_user
    return nil unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def log_in(user)
    reset_session # For security reasons, we clear the session data before login
    session[:user_id] = user.id
    session[:expires_at] = Time.current + SESSION_DURATION_TIME
  end


  def log_out
    reset_session
  end

  def should_log_out?
    session[:expires_at] && session[:expires_at].to_time < Time.current
  end
end
