# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trader', type: :request do
  describe 'Post' do
    before(:each) do
      @account_trader = FactoryBot.create :trader
      @account_trader.confirm
      sign_in @account_trader

      client = IEX::Api::Client.new(
        publishable_token: 'pk_9d26176d72f845e7ad03a261815928c5',
        secret_token: 'secret_token',
        endpoint: 'https://cloud.iexapis.com/v1'
      )

      @top_10_stocks = client.stock_market_list(:mostactive)
      @dummy_stock = {}

      @top_10_stocks.each do |stock|
        @dummy_stock[:stock_name] = stock.symbol
        @dummy_stock[:bought_price] = stock.latest_price
        @dummy_stock[:change_percent] = stock.change_percent
        @dummy_stock[:quantity] = 2
        break
      end
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
        p "hello"
        p @dummy_stock
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
            stock_name: 'AMD',
            quantity: 1
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
