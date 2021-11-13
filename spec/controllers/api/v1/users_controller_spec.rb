require 'rails_helper'

# user登録のテストをかく
describe Api::V1::UsersController, type: :controller do
  # describe 'GET Index' do
  #   subject { get :index }
  #   it do
  #     subject
  #     expect(response.status).to eq 200
  #   end
  # end

  describe 'POST sign_up' do
    subject { post :sign_up, params: sign_up_attribute}

    let!(:sign_up_attribute) do
      {
        user: {
          nickname: nickname,
          email: 'test@gmail.com',
          password: 'testtest',
          sex: 1,
          birth_year: 2000,
          birth_month: 12,
          birth_day: 4,
          introduction: 'こんにちは。音楽仲間を募集しています。',
          syukou: '趣向',
          commitment: 5,
          tweet: '1111111111',
          prefecture_id: 1,
          user_profile_images_attributes: [
            {          
              image: 'test.img',
              position: 1
            },
          ],
          user_active_dates_attributes: [
            {date: 0},
            {date: 1}
          ],
          user_sns_services_attributes: [
            {url: 'https://instagram.com/p/hogehoge', sns_type: 4}
          ]
        },
        music_categories: [
          {category_id: 1, position: 1},
          {category_id: 2, position: 2}
        ],
        affected_musicians: [
          {musician_id: 1, position: 1}
        ],
        instruments: [
          {
            instrument_type_id: 1,
            experience: 3,
            skill_level: 5,
            position: 1,
            special_skills: [
              1,
              2,
              3
            ],
            equipments: [
              1
            ],
            live_experiences: [1]
          }
        ]
      }
    end
    let!(:nickname) {'test'}

    context '全ての値が正しく入力されている場合' do
      let!(:user_id) do
        { user_id: 1 }
      end
      let!(:token) do
        'eyJhbGciOiJIUzI1NiJ9.eyJkYXRhIjp7InVzZXJfaWQiOjJ9LCJleHAiOjE2MjUzODY0MDV9.knnRHDGUxkC8KvxAv7edJ-ImOwM6mI3iJfaO68hJbMw'
      end
      before do
        allow(controller).to receive(:encode_token).and_return(token)
      end

      it 'レコードが作成される' do
        subject
        expect(response.status).to eq 200
        expect(User.first.nickname).to eq 'test'
        expect(User.first.email).to eq 'test@gmail.com'
      end

      it 'JWTが返る' do
        subject
        response_json = JSON.parse(response.body)
        expect(response_json['token']).to eq token
      end
    end

    context '値が正しく入力されていない場合' do
      context 'nicknameを入力していない場合' do
        let!(:nickname) { nil }

        it 'エラーメッセージを返す' do
          subject
          response_json = JSON.parse(response.body)
          expect(response_json['error']['nickname']).to eq ["can't be blank"]
        end
      end
    end
  end
end
