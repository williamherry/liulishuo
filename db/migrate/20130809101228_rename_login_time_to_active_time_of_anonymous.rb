class RenameLoginTimeToActiveTimeOfAnonymous < ActiveRecord::Migration
  def change
    rename_column :anonymous_users, :total_visiting_time_in_minutes, :total_active_time
  end
end
