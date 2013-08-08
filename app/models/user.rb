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

end
