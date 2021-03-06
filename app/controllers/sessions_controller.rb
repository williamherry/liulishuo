class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    user = User.find(session[:user_id])
    user.reset_last_see_time
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
