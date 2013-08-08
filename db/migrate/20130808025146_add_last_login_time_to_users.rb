class AddLastLoginTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_login_time, :datetime, default: 0
  end
end
