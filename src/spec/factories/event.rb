FactoryBot.define do 
  factory :event do 
    title { Faker::Lorem.sentence(word_count: rand(4..6) ) }
    description { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    location { FactoryBot.create(:location) }
    start_date { DateTime.now }
    end_date { Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 6) }
  end 
end 