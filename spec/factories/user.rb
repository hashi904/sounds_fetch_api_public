FactoryBot.define do
  factory :user, class: User do

    sequence(:id) { |n| n }
    nickname { 'testuser1' }
    email { Faker::Internet.email }
    password { 'hogehoge' }
    sex { 0 }
    birth_year { 1990 }
    birth_month { 12 }
    birth_day { 1 }
    introduction { 'こんにちは。よろしくお願いします。' }
    tweet { 'testtest' }
    authentication_flag { 0 }
    prefecture_id { create(:prefecture).id }
  end
end
