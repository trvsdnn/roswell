FactoryGirl.define do
  sequence :title do |i|
    "title #{i}"
  end

  factory :base_item do
    title
    current_user { create(:user) }
    last_updated_by_ip '127.0.0.1'
  end

  factory :generic_account do
    title
    username 'foo'
    password 'sssh'
    current_user { create(:user) }
    last_updated_by_ip '127.0.0.1'
  end

  factory :web_account do
    title
    username 'foo'
    password 'sssh'
    current_user { create(:user) }
    last_updated_by_ip '127.0.0.1'
  end

  factory :note do
    title
    body 'foo'
    current_user { create(:user) }
    last_updated_by_ip '127.0.0.1'
  end

  factory :software_license do
    title
    license_key 'foo'
    current_user { create(:user) }
    last_updated_by_ip '127.0.0.1'
  end
end
