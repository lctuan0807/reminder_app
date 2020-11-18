FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@factory.com" }
    password { '1sdfbsdafh23' }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
  end
end
