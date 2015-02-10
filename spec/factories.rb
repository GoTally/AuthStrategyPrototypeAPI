FactoryGirl.define do
  factory :user do
    first_name 'Tyler'
    last_name 'Ewing'
    email 'tewing10@gmail.com'

    factory :user_with_tokens do
      transient do
        tokens_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:token, evaluator.tokens_count-1, user: user)
        user.expire_tokens
        user.tokens << create(:token)
      end
    end
  end

  factory :token do
    value { SecureRandom.hex }

    factory :token_expired do
      expired_at { Time.now }
    end
  end
end
