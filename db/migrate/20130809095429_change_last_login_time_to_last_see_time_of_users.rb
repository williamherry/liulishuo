class ChangeLastLoginTimeToLastSeeTimeOfUsers < ActiveRecord::Migration
  def change
    rename_column :users, :last_login_time, :last_see_time
  end
end
