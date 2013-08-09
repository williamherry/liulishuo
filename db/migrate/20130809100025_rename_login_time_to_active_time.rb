class RenameLoginTimeToActiveTime < ActiveRecord::Migration
  def change
    rename_column :users, :total_login_time_in_minutes, :total_active_time
  end
end
