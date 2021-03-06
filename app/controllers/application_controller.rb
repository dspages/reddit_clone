class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :moderator?

  def log_in!(user)
    session[:session_token]=user.reset_session_token!
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token]=nil
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def moderator?(sub)
    @current_user.subs_moderated.include?(sub)
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def require_moderator?(sub)
    redirect_to subs_url unless moderator?(sub)
    moderator?(sub)
  end

  def require_logged_out
    redirect_to subs_url if logged_in?
  end

end
