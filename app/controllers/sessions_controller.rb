class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      message = t "common.sign_in_message",
        username: user.username, login_count: user.login_count
      redirect_to root_url, :notice => message
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
