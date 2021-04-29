# frozen_string_literal: true

class Activity < ApplicationRecord
  include TranslateEnum

  has_and_belongs_to_many :week_days
  has_and_belongs_to_many :volunteers
  has_and_belongs_to_many :students
  belongs_to :location
  has_one_attached :display_image

  enum status: %i[active closed]
  translate_enum :status

  validate :verify_availability
  validates :max_capacity, numericality: { greater_than_or_equal_to: 1, allow_blank: true }
  validates_presence_of :name, :description, :starts_at, :ends_at

  def students_count
    students.count
  end

  def percent_of
    (students.count.to_f / max_capacity.to_f) * 100.0
  end

  private

  def verify_availability
    unless max_capacity.nil?
      if students.count > max_capacity
        errors.add(:students, :max_length, max: max_capacity,
                                           message: 'Capacidade máxima de alunos atingida.')
      end
    end
  end
end
