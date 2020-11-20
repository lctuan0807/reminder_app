FactoryBot.define do
  factory :short_message do
    phone_number { create(:user).phone }
    content { Faker::Lorem.sentence }
    user { create(:user) }
  end
end
