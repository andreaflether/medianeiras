# frozen_string_literal: true

class Event < ApplicationRecord
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :location_selection_type

  enum location_selection_type: %i[existing_location new_location]

  belongs_to :location
  accepts_nested_attributes_for :location

  validates :title, presence: true, length: { in: 1..255, allow_blank: true }
  validates :description, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :scheduled_for, presence: true

  validate :ends_at_must_be_after_starts_at, if: -> { hour_fields_are_present? }

  def ends_at_must_be_after_starts_at
    errors.add(:ends_at, I18n.t('admin.events.ends_at.invalid_time')) if ends_at < starts_at
  end

  def hour_fields_are_present?
    starts_at.present? && ends_at.present?
  end

  def datetime_from_date_and_time(date, time)
    DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec, '-0300')
  end

  def start_date
    datetime_from_date_and_time(scheduled_for, starts_at)
  end

  def end_date
    datetime_from_date_and_time(scheduled_for, ends_at)
  end

  scope :happening_this_month, lambda {
    where(scheduled_for: Date.today..Date.today.end_of_month)
  }
end
