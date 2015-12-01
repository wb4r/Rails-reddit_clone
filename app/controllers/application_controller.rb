class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # this line makes these controller methods also 
  # available to the view templates
  helper_method :current_user, :logged_in?

  def current_user
    # what ||= means is that if the @ exists not to run the code after
    # so we dont hit the DB constantly
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # !!4 => true
    # !!nil => false
    !!current_user    
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in"
      redirect_to root_path
    end
  end

  def require_admin
    access_denied unless logged_in? and current_user.admin?    
  end

  def access_denied
    flash[:error] = "You can't do that. Contact Admin if the problem persists."
    redirect_to root_path
  end
end
