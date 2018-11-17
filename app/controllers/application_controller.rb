class ApplicationController < ActionController::Base
  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!@current_user
  end
end
