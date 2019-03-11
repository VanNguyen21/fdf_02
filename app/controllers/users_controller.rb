class UsersController < ApplicationController
  before_action :load_user, only: [:show,:update,:edit]

  def show
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

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = I18n.t "profile_updated"
      redirect_to current_user
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
  end


  def load_user
    @user = current_user
  end
end
