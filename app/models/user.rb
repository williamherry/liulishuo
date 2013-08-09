class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of :username
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :username

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user and user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user.increase_login_count
      user.update_last_login_time
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def increase_login_count
    update_attributes(login_count: login_count + 1)
  end

  def update_last_login_time
    update_attributes(last_login_time: Time.now)
  end

  def update_total_login_time_in_minutes
    current_login_time = ((Time.now - last_login_time)/1.minute).to_i
    update_attributes(total_login_time_in_minutes: total_login_time_in_minutes + current_login_time)
  end

  def total_login_time
    total_login_time_in_minutes + ((Time.now - last_login_time)/1.minute).to_i
  end

end
