FactoryGirl.define do
  sequence :username do |i|
    "user#{i}"
  end

  factory :user do
    username
    password 'please'
    password_confirmation 'please'

    factory :user_with_groups do
      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:group, 5, :user => user)
      end
    end
  end

  factory :admin, :class => User do
    username 'admin'
    password 'please'
    password_confirmation 'please'
  end
end