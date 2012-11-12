FactoryGirl.define do
  sequence :name do |i|
    "group #{i}"
  end

  factory :group do
    name
  end
end