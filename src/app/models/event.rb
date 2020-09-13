class Event < ApplicationRecord
  belongs_to :location
  accepts_nested_attributes_for :location
  validates_presence_of :title, :start_date, :end_date, :description, :location

  scope :this_month, lambda {
    where(start_date: Date.today..Date.today.end_of_month)
  }

  def is_today?
    self.start_date.day == Date.today.day
  end 
end
