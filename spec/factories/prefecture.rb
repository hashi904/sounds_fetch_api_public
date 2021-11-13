FactoryBot.define do
  factory :prefecture, class: Prefecture do
    sequence(:id) { |n| n }
    name { '北海道' }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
