FactoryGirl.define do
  factory :user do
    first_name 'Tyler'
    last_name 'Ewing'
    email 'tewing10@gmail.com'

    factory :user_with_token do
      transient do
        tokens_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:token, evaluator.tokens_count, user: user)
      end
    end
  end

  factory :token do
    value { SecureRandom.hex }
  end
end
