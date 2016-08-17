class User < ActiveRecord::Base
  has_many :secrets
  has_many :likes, dependent: :destroy 
  has_many :secrets_liked, through: :likes, source: :secret
  validates :name, :email, presence: true
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: {case_sensitive: false}, format: {with: email_regex} 
  has_secure_password
end
