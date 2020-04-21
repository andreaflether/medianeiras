class Activity < ApplicationRecord
  has_and_belongs_to_many :week_days
  has_and_belongs_to_many :volunteers
  has_and_belongs_to_many :students
  
  validates :max_capacity, presence: true, numericality: { greater_than_or_equal_to: 1, allow_blank: true }
  validates_presence_of :name, :description, :starts_at, :ends_at
  validate :number_of_students

  def available
    self.max_capacity - students_count
  end 

  def students_count
    self.students.count
  end 

  def percent_of
    (self.students.count.to_f / self.max_capacity.to_f) * 100.0
  end

  private

  def number_of_students
    errors.add(:students, :max_length, 
    :message => "^Capacidade máxima de alunos atingida.") if students.count > self.max_capacity
  end

 
end
