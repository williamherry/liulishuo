class CreateAnonymousUsers < ActiveRecord::Migration
  def change
    create_table :anonymous_users do |t|
      t.string :remote_ip
      t.datetime :last_see_time

      t.timestamps
    end
  end
end
