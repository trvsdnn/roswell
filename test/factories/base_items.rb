FactoryGirl.define do
  sequence :title do |i|
    "title #{i}"
  end

  factory :base_item do
    title
    current_user { create(:user) }
  end

  factory :generic_account do
    title
    username 'foo'
    password 'sssh'
    current_user { create(:user) }
  end

  factory :web_account do
    title
    username 'foo'
    password 'sssh'
    current_user { create(:user) }
  end

  factory :note do
    title
    body 'foo'
    current_user { create(:user) }
  end

  factory :software_license do
    title
    license_key 'foo'
    current_user { create(:user) }
  end
end
