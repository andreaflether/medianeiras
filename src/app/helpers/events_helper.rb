# frozen_string_literal: true

module EventsHelper
  def full_time(starts_at, ends_at)
    [starts_at, ends_at].map { |time| l(time, format: :compact) }.join(' às ')
  end
end
