# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trader', type: :request do
  let(:stock) do
    Stock.new(
      company_name: 'Tesla',
      symbol: 'Tesla',
      current_price: 242.42,
      change_percent: 0.242,
      quantity: 5
    )
  end
  let(:account_trader) do
    Account.new(
      first_name: 'account',
      last_name: 'test1',
      balance: 2500.25,
      is_approved: true,
      role: 'trader'
    )
  end

  let(:transaction_buy) do
    Transaction.new(
      stock_name: 'Tesla',
      symbol: 'Tesla',
      quantity: 1,
      bought_price: 244.24,
      transaction_type: 'buy'
    )
  end

  let(:transaction_sell) do
    Transaction.new(
      stock_name: 'Tesla',
      symbol: 'Tesla',
      quantity: 1,
      bought_price: 244.24,
      transaction_type: 'sell'
    )
  end

  let(:has_stock) do
    transaction_buy.quantity < stock.quantity
  end

  let(:has_symbol) do
    transaction_buy.symbol == stock.symbol
  end

  let(:has_balance) do
    transaction_buy.bought_price < account_trader.balance
  end

  let(:transaction_total_price) do
    transaction_buy.bought_price * transaction_buy.quantity
  end

  let(:has_bought) do
    transaction_buy.quantity > 0
  end

  describe 'Post' do
    before(:each) do
      @account_trader = FactoryBot.create :trader
      @account_trader.confirm
      sign_in @account_trader
    end

    describe 'trader/buy' do
      before(:each) do
        headers = { 'ACCEPT' => 'application/json' }
        post '/trader/buy', params: { transaction: transaction_buy }, headers:
      end

      it '1, successfully bought a stock' do
        expect(response).to have_http_status(200) if transaction_total_price && has_stock && has_balance
        expect(response).to have_http_status(:success)
      end

      it '2, must have a stock' do
        expect(has_stock).to be_true unless has_stock
      end

      it '3, account balance should be greater than transaction bought price on buying' do
        expect(has_balance).to be_true unless has_balance
      end

      it '4, company should exist' do
        expect(has_symbol).to be_truthy
      end

      it '5, response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    describe 'trader/sell' do
      before(:each) do
        headers = { 'ACCEPT' => 'application/json' }
        post '/trader/sell', params: { transaction: transaction_sell }, headers:
      end

      it '1, successfully sell a stock' do
        expect(has_bought).to be_true unless has_bought
        expect(response).to have_http_status(:success)
      end

      it '2, response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
