class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @user = User.new # for creating new user
    @users = User.all
  end
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.clear
      flash.now[:notice] = "User created"
    else
      flash.now[:notice] = "#{@user.errors.full_messages}"
    end
    respond_with(@user) { |f| f.html { redirect_to users_path } }
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
