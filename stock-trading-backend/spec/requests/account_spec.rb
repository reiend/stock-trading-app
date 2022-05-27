require 'rails_helper'

RSpec.describe 'Account\'s Request', type: :request do
  describe 'POST' do
    before(:each) do
      headers = { 'ACCEPT' => 'application/json' }
      post '/signup', params: {
        account: {
          first_name: 'trader_100',
          last_name: 'trader_100',
          email: 'trader_100@gmail.com',
          password: 'trader_100',
          confirmed_at: nil,
          password_confirmation: 'trader_100'
        }
      }, headers:
    end
    describe '/signup' do
      it '1, response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      it '2, successfully created an account' do
        expect(response).to have_http_status(:success)
      end
      it '3, after signup account needs an email confirmation' do
        expect(JSON.parse(response.body)['confirmed_at']).to be_nil
      end
    end
    describe '/signin' do
      it '1, response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      it '2, successfully signin' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
