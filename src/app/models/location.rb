class Location < ApplicationRecord
  has_many :events
  has_many :activities
  validates_presence_of :address
end
