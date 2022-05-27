require 'rails_helper'

RSpec.describe 'Trader', type: :request do
  describe 'Post' do
    before(:each) do
      @account_trader = FactoryBot.create :trader
      @account_trader.confirm
      sign_in @account_trader
    end

    describe 'trader/buy' do
      before(:each) do
        headers = { 'ACCEPT' => 'application/json' }
        post '/trader/buy', params: {
          transaction: {
            stock_name: 'Tesla',
            quantity: 2,
            bought_price: 244.24,
            transaction_type: 'buy'
          }
        }, headers:
      end

      it '1, successfully bought a stock' do
        expect(response).to have_http_status(200)
      end

      it '2, response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    describe 'trader/sell' do
      before(:each) do
        headers = { 'ACCEPT' => 'application/json' }
        post '/trader/sell', params: {
          transaction: {
            id: 2
          }
        }, headers:
      end

      it '1, successfully sold a stock' do
        expect(response).to have_http_status(200)
      end

      it '2, response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
