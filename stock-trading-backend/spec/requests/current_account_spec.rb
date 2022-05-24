require 'rails_helper'

RSpec.describe 'CurrentAccounts', type: :request do
  describe 'Get' do
    before do
      @account = FactoryBot.create :account
      @account.confirm
      sign_in @account
      get '/current_account'
    end
    describe '/current_account' do
      it 'success response' do
        expect(response).to have_http_status(:success)
      end
      it 'response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
