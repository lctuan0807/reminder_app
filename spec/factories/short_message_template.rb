FactoryBot.define do
  factory :short_message_template do
    sequence(:name) { |n| "SMS Template #{1}" }
    enabled { true }
  end
end
