require 'rails_helper'

describe Api::V1::TopController, type: :controller do
  describe 'GET index' do
    subject { get :index }
    before do
      create(:user)
      # create(:prefecture)
    end

    it 'http status 200' do
      subject
      expect(response.status).to eq 200
    end
  end
end
