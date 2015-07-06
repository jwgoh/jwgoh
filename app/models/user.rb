class User < ActiveRecord::Base
  attr_accessor :remember_me_token

  has_secure_password

  # Validations
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  validates :password, length: { minimum: 8 }

  # Class methods
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Instance methods
  def remember
    self.remember_me_token = User.new_token
    update_attribute(:remember_me_digest, User.digest(remember_me_token))
  end

  def forget
    update_attribute(:remember_me_digest, nil)
  end

  def authenticated?(remember_me_token)
    return false if remember_me_digest.blank?
    BCrypt::Password.new(remember_me_digest).is_password?(remember_me_token)
  end
end
