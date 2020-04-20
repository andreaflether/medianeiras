class WeekDay < ApplicationRecord
  has_and_belongs_to_many :activities
end
