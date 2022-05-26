require 'rails_helper'

RSpec.describe 'CurrentAccount\'s Request', type: :request do
  describe 'Get' do
    describe 'Trader' do
      before(:each) do
        @account = FactoryBot.create :trader
        @account.confirm
        sign_in @account
      end

      describe '/current_account' do
        before(:each) do
          get '/current_account'
        end
        it '1, success response' do
          expect(response).to have_http_status(:success)
        end
        it '2, response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
        it '3, render current_account as trader should not raise an error' do
          expect { response.body }.to_not raise_error
        end
        it '4, account is successfully created' do
          trader_created_id = JSON.parse(response.body)['id']
          expect(@account).to_not be_nil
          expect(Account.where(id: trader_created_id)).to_not be_nil
        end
        it '5, to signin, account trader must be signup' do
          trader_created_id = JSON.parse(response.body)['id']
          expect(Account.where(id: trader_created_id)).to_not be_nil
        end
      end

      describe '/current_account/stocks_bought' do
        before(:each) do
          get '/current_account/stocks_bought'
        end
        it '1, success response' do
          expect(response).to have_http_status(:success)
        end
        it '2, response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
        it '3, render all stocks bought should not raise an error' do
          expect { response.body }.to_not raise_error
        end
      end
      describe '/current_account/stocks_sold' do
        before(:each) do
          get '/current_account/stocks_sold'
        end
        it '1, success response' do
          expect(response).to have_http_status(:success)
        end
        it '2, response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
        it '3, render all stocks sold should not raise an error' do
          expect { response.body }.to_not raise_error
        end
      end
      describe '/current_account/transactions' do
        before(:each) do
          get '/current_account/transactions'
        end
        it '1, success response' do
          expect(response).to have_http_status(:success)
        end
        it '2, response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
        it '3, render all transactions should not raise an error' do
          expect { response.body }.to_not raise_error
        end
      end
    end
    describe 'Admin' do
      before(:each) do
        @account = FactoryBot.create :admin
        @account.confirm
        sign_in @account
      end
      describe '/current_account' do
        before(:each) do
          get '/current_account'
        end
        it '1, success response' do
          expect(response).to have_http_status(:success)
        end
        it '2, response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
        it '3, render current_account as admin should not raise an error' do
          expect { response.body }.to_not raise_error
        end
      end
      describe '/current_account/trader_list' do
        before(:each) do
          get '/current_account/trader_list'
        end
        it '1, success response' do
          expect(response).to have_http_status(:success)
        end
        it '2, response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
        it '3, render all trader should not raise an error' do
          expect { response.body }.to_not raise_error
        end
      end
    end
  end
end
