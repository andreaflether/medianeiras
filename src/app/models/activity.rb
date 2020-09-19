class Activity < ApplicationRecord
  has_and_belongs_to_many :week_days
  has_and_belongs_to_many :volunteers
  has_and_belongs_to_many :students
  belongs_to :location
  has_one_attached :display_image

  validate :verify_availability
  validates :max_capacity, numericality: { greater_than_or_equal_to: 1, allow_blank: true }
  validates_presence_of :name, :description, :starts_at, :ends_at
  
  def students_count
    self.students.count
  end 

  def percent_of
    (self.students.count.to_f / self.max_capacity.to_f) * 100.0
  end

  private

  def verify_availability
    unless self.max_capacity == nil
      errors.add(:students, :max_length, max: self.max_capacity,
      :message => "Capacidade máxima de alunos atingida.") if self.students.count > self.max_capacity
    end 
  end
end
