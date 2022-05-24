require 'rails_helper'

RSpec.describe 'CurrentAccounts', type: :request do
  describe 'Get' do
    describe 'Admin and Trader' do
      before do
        @account = FactoryBot.create :account
        @account.confirm
        sign_in @account
      end
      describe '/current_account' do
        before(:each) do
          get '/current_account'
        end
        it 'success response' do
          expect(response).to have_http_status(:success)
        end
        it 'response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end

    describe "Trader" do
      describe '/current_account/stocks_bought' do
        before(:each) do
          get '/current_account/stocks_bought'
        end
        it 'success response' do
          expect(response).to have_http_status(:success)
        end
        it 'response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
      describe '/current_account/stocks_sold' do
        before(:each) do
          get '/current_account/stocks_sold'
        end
        it 'success response' do
          expect(response).to have_http_status(:success)
        end
        it 'response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
      describe '/current_account/transactions' do
        before(:each) do
          get '/current_account/transactions'
        end
        it 'success response' do
          expect(response).to have_http_status(:success)
        end
        it 'response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end
    describe "Admin" do
      describe '/current_account/trader_list' do
        before(:each) do
          get '/current_account/trader_list'
        end
        it 'success response' do
          expect(response).to have_http_status(:success)
        end
        it 'response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end

    end
  end
end
