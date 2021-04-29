# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence(word_count: rand(4..6)) }
    description { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    start_date { DateTime.now }
    end_date { Faker::Time.between(from: DateTime.now + 1.hour, to: DateTime.now + 3.hours) }
    location
  end
end
