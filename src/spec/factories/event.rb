FactoryBot.define do 
  factory :event do 
    title { Faker::Lorem.sentence(word_count: rand(4..6) ) }
    description { Faker::Lorem.paragraph }
    location { Faker::Address.full_address }
    start_date { Faker::Time.between(from: DateTime.now, to: DateTime.now + 6) }
  end 
end 