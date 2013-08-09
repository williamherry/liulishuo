class AddTotalVisitingTimeInMinutesToAnonymousUser < ActiveRecord::Migration
  def change
    add_column :anonymous_users, :total_visiting_time_in_minutes, :integer, default: 0
  end
end
