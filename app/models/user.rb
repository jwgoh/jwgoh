class User < ActiveRecord::Base

  validates_presence_of :name

  validates_presence_of :email
  validates_uniqueness_of :email, case_senstive: false
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  validates :password, length: { minimum: 8 }, if: :password
  validates :password, confirmation: true, if: :password
  validates :password_confirmation, presence: true, if: :password

  has_secure_password

end
