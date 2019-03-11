class SessionsController < ApplicationController
  before_action :load_user, only: [:edit,:show,:update]
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      if params[:session][:remember_me] == Settings.sessions.remember_me
        remember(user)
      else
        forget(user)
      end
      redirect_to root_path
    else
      flash.now[:danger] = I18n.t "invalid"
      render "new"
    end
  end


  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
