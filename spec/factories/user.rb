FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@factory.com" }
    password { '1sdfbsdafh23' }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }

    after(:build) do |user| 
      user.class.any_instance.stub(:after_sign_up)
    end

    factory :user_with_callback do
      after(:create) do |user| 
        user.class.any_instance.unstub(:after_sign_up)
      end
    end
  end
end
