class UsersController < ApplicationController
  before_action :load_user, only: [:show,:update,:edit]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def show;   end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      edirect_to root_path
    else
      render new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render user_edit_path
    end
  end

  private

  def user_params
      params.require(:user)
      .permit :full_name, :address, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find(params[:id])
    return if @user
    flash[:danger] = t "please_login"
    redirect_to root_path
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] =  t "please_login"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user? @user
  end
end
