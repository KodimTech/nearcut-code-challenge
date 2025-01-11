FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    password { SecureRandom.hex }
  end
end
