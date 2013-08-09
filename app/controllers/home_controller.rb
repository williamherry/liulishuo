class HomeController < ApplicationController
  def index
    if current_user
      @user = current_user
    else
      @user = AnonymousUser.find_by_remote_ip(request.remote_ip)
      if @user
        @user.update_total_visiting_time_in_minutes
        @user.reset_last_see_time
      else
        @user = AnonymousUser.create(remote_ip: request.remote_ip,
                                     last_see_time: Time.now
                                    )
      end
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
