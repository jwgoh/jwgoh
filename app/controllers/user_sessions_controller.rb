class UserSessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params.fetch(:user_sessions)[:email])
    if @user && @user.authentication(params.fetch(:user_sessions)[:password])
      log_in(@user)
      flash[:success] = "You have successfully logged in!"
    else
      flash[:error] = "Invalid email or password"
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path, success: "Logged Out"
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
