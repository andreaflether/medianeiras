# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :location
  accepts_nested_attributes_for :location

  attr_accessor :location_selection_type
  # attr_accessor :display_image_cache

  enum location_selection_type: %i[existing_location new_location]
  enum status: %i[active closed]

  mount_uploader :display_image, DisplayImageUploader

  acts_as_taggable_on :week_days

  # validate :availability, unless: -> { max_capacity.nil? }

  WEEK_DAYS = I18n.t('date.basic_day_names')

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :max_capacity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1, allow_blank: true
            }

  def occupation
    (students.count.to_f / max_capacity.to_f) * 100.0
  end

  def availability
    errors.add(:base, message: I18n.t('admin.base', max: max_capacity)) if students.count > max_capacity
  end
end
