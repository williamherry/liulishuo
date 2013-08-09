class HomeController < ApplicationController
  def index
    if current_user
      @user = current_user
      @user.reset_last_see_time
    else
      @user = AnonymousUser.find_or_create_by_remote_ip(request.remote_ip)
      @user.reset_last_see_time
    end

    @active_user_count = User.active.count
    @active_anonymous_count = AnonymousUser.active.count
  end

  def report
    @active_user_count = User.active.count
    @active_anonymous_count = AnonymousUser.active.count
    render :json=>{:active_user_count => @active_user_count,
                   :active_anonymous_count => @active_anonymous_count
                  }.to_json
  end
end
