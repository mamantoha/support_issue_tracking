FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'

    trait :admin do
      role 'admin'
    end

    trait :manager do
      role 'manager'
    end

  end
end
