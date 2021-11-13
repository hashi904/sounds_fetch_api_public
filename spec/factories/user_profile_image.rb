FactoryBot.define do
  factory :user_profile_images, class: UserProfileImage do
    sequence(:id) { |n| n }
    image { 'test.img' }
    position { 1 }
    user_id {  }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
