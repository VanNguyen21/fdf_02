class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = I18n.t "welcome"
      edirect_to root_path
    else
      render "new"
    end
  end

  private

  def user_params
      params.require(:user)
      .permit :full_name, :address, :email, :password, :password_confirmation
  end
end
