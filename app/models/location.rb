# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :events
  has_many :activities

  validates :address, presence: true
  validates :description, presence: true, uniqueness: true
end
