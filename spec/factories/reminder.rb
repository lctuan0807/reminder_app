FactoryBot.define do
  factory :reminder do
    title { Faker::Lorem.sentence }
    period { 5 }
    period_type { 'day' }
  end
end
