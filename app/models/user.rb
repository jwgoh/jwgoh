class User < ActiveRecord::Base
  attr_accessor :remember_me_token

  has_secure_password

  validates_presence_of :name

  validates_presence_of :email
  validates_uniqueness_of :email, case_senstive: false
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  validates :password, length: { minimum: 8 }
end
