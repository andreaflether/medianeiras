# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :person
  has_and_belongs_to_many :activities

  def person_name
    person.name
  end
end
