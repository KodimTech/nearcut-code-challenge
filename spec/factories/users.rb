FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    password_digest { SecureRandom.hex }
  end
end
