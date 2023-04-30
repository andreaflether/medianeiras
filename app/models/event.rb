# frozen_string_literal: true

class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged history finders]

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

  def date_and_title
    "#{scheduled_for.strftime('%d%m%y')} #{title}"
  end

  def full_time
    "#{I18n.l(starts_at, format: :compact)} às #{I18n.l(ends_at, format: :compact)}"
  end

  def datetime_and_title
    "#{scheduled_for.strftime('%d%m%y')} #{full_time} #{title}"
  end

  def slug_candidates
    %i[
      date_and_title
      datetime_and_title
    ]
  end

  def should_generate_new_friendly_id?
    title_changed? || scheduled_for_changed? || super
  end

  scope :happening_this_month, lambda {
    where(scheduled_for: Date.today..Date.today.end_of_month)
  }
end
