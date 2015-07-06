class UserSessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(user_sessions_params[:email])
    if @user && @user.authenticate(user_sessions_params[:password])
      log_in(@user)
      user_sessions_params[:remember_me] == "1" ? remember(@user) : forget(@user)
      flash[:success] = "You have successfully logged in!"
    else
      flash[:error] = "Invalid email or password"
    end
    redirect_to request.referrer || root_path
  end

  def destroy
    if logged_in?
      log_out
      flash[:success] = "You have successfully logged out!"
    end
    redirect_to root_path
  end

  private

  def user_sessions_params
    params.require(:user_sessions).permit(:email, :password, :remember_me)
  end
end
