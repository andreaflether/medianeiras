FactoryBot.define do 
  factory :user do 
    full_name { Faker::Name.name_with_middle }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    
    trait :visitor do 
      role { 'user' }
    end

    trait :admin do 
      role { 'admin' }
    end

    trait :superadmin do 
      role { 'superadmin' }
    end
  end 
end 