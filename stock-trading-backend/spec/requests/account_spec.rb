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
          password_confirmation: 'trader_100'
        }
      }, headers:
    end
    describe '/signup' do
      it 'response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      it 'response created' do
        expect(response).to have_http_status(:success)
      end
    end
    describe '/signin' do
      it 'response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      it 'response success' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
