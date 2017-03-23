class User < ActiveRecord::Base
  has_many :comments
  has_many :events
  has_many :user_events
  has_many :events, :through => :user_events

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i


  validates :first_name, :last_name, :email, :city, :state, :password, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :state, length:{is:2}
  validates :password, length:{minimum:8}
  validates_confirmation_of :password

end
