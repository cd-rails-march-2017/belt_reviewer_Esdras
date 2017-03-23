class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :user_events
  has_many :users, :through => :user_events

  validates :name, :date, :location, presence: true
  validates :state, length:{is: 2}
  validate :date_is_future

  def date_is_future
    errors.add(:date, "can't be in the past") if !date.blank? and date < Date.today
  end
end
