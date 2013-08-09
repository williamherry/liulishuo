class AnonymousUser < ActiveRecord::Base

  def update_total_visiting_time_in_minutes
    current_visiting_time = ((Time.now - last_see_time)/1.minute).to_i
    update_attributes(total_visiting_time_in_minutes: total_visiting_time_in_minutes + current_visiting_time)
  end

  def reset_last_see_time
    update_attributes(last_see_time: Time.now)
  end

  def total_visiting_time
    total_visiting_time_in_minutes + ((Time.now - last_see_time)/1.minute).to_i
  end

end
