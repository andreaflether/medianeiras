class Event < ApplicationRecord
  validates_presence_of :title, :start_date, :description, :location
end
