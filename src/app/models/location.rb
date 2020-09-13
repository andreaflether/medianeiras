class Location < ApplicationRecord
  has_many :events
  validates_presence_of :address
end
