class Activity < ApplicationRecord
  has_and_belongs_to_many :week_days
  validates :max_capacity, presence: true, numericality: { greater_than_or_equal_to: 1, allow_blank: true }
  validates_presence_of :name, :description, :starts_at, :ends_at
  has_and_belongs_to_many :volunteers
end
