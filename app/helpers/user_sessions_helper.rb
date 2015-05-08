module UserSessionsHelper
  def log_in(user)
    # Temporary cookie expires immediately when the browser is closed
    session[:user_id] = user.id
  end

  def current_user
    # find raises an exception if the user id doesn't exist
    # find_by returns nil
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    @current_user.present?
  end
end
