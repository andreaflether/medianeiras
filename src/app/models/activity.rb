class Activity < ApplicationRecord
  validates :max_capacity, numericality: { greater_than_or_equal_to: 1 }, presence: true
end
