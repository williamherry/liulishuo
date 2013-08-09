class Guest < ActiveRecord::Base

  scope :active, lambda {|period=5|
    where("last_see_time > ?", period.minutes.ago)
  }

  def reset_last_see_time
    initialize if last_see_time.nil?
    update_total_active_time
    update_attributes(last_see_time: Time.now)
  end

  private

    def update_total_active_time
      current_active_time = ((Time.now - last_see_time)/1.minute).to_i
      unless current_active_time <= 5
        update_attributes(total_active_time: total_active_time + current_active_time)
      end
    end

    def initialize
      update_attributes(last_see_time: Time.now)
    end

end
