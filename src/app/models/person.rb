class Person < ApplicationRecord
  has_one :student
  accepts_nested_attributes_for :student
  has_one :volunteer
  accepts_nested_attributes_for :volunteer
  has_one :promulher_form
end
