class HomeController < ApplicationController
  def index
    if current_user
      @user = current_user
      @user.reset_last_see_time
    else
      @user = Guest.find_or_create_by_remote_ip(request.remote_ip)
      @user.reset_last_see_time
    end

    @active_users_count = User.active.count
    @active_guests_count = Guest.active.count
  end

  def report
    @active_users_count = User.active.count
    @active_guests_count = Guest.active.count
    render :json=>{:active_users_count => @active_users_count,
                   :active_guests_count => @active_guests_count
                  }.to_json
  end
end
