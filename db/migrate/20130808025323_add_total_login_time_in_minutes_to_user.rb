class AddTotalLoginTimeInMinutesToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_login_time_in_minutes, :integer, default: 0
  end
end
