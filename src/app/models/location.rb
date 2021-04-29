# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :events # , inverse_of: :location
  has_many :activities

  validates :address, presence: true
  validates :description, presence: true, uniqueness: true
end
