class Volunteer < ApplicationRecord
  belongs_to :person
  has_and_belongs_to_many :activities
  
  def person_name
    self.person.name
  end 
end
