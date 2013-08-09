class RenameAnonymousUsersToGuests < ActiveRecord::Migration
  def change
    rename_table :anonymous_users, :guests
  end
end
