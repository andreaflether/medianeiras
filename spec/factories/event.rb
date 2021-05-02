# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence(word_count: rand(4..6)) }
    description { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    scheduled_for { Time.now }
    starts_at { Time.now }
    ends_at { Time.now + 1.hour }
    location
  end
end
