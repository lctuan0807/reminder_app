FactoryBot.define do
  factory :reminder do
    title { Faker::Lorem.sentence }
    due_after { 5 }
  end
end
