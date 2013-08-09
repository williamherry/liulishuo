class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of :username
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :username

  scope :active, lambda {|period=5|
    where("last_see_time > ?", period.minutes.ago)
  }

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user and user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user.authenticate_callback
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

  def authenticate_callback
    initialize if last_see_time.nil?
    increase_login_count
    reset_last_see_time
  end

  def reset_last_see_time
    update_total_active_time
    update_attributes(last_see_time: Time.now)
  end

  def total_login_time
    total_active_time + ((Time.now - last_see_time)/1.minute).to_i
  end

  private

    def increase_login_count
      update_attributes(login_count: login_count + 1)
    end

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
