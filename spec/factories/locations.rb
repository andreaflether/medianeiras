# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    description { Faker::Lorem.sentence(word_count: 3) }
    address { "#{Faker::Address.street_address} - #{Faker::Address.street_name}" }
  end
end
