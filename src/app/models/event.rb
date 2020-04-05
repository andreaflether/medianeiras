class Event < ApplicationRecord
  validates_presence_of :title, :location, :start_date, :description
end
