FactoryGirl.define do
  factory :user do
    first_name 'Tyler'
    last_name 'Ewing'
    email 'tewing10@gmail.com'
  end

  factory :token do
    value { SecureRandom.hex }
  end
end
