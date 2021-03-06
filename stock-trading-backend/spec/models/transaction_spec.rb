# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Transaction's Model", type: :model do
  # Transactions
  let(:transaction) do
    Transaction.new(
      transaction_type: 'buy',
      bought_price: 425.52,
      stock_name: 'Tesla',
      symbol: 'Tesla',
      quantity: 2
    )
  end

  it '1, should belongs_to account' do
    account = Transaction.reflect_on_association(:account)
    expect(account.macro).to eq(:belongs_to)
  end

  context 'transaction_type' do
    it '1, must be a transaction_type buy or sell' do
      expect(transaction.transaction_type).to eq('buy').or eq('sell')
    end
  end

  context 'stock name' do
    it '1, must be type String' do
      expect(transaction.stock_name).to be_a String
    end
    it '2, must have a value' do
      expect(transaction.stock_name).to_not be_nil
    end
  end

  context 'symbol' do
    it '1, must be type String' do
      expect(transaction.symbol).to be_a String
    end
    it '2, must have a value' do
      expect(transaction.symbol).to_not be_nil
    end
  end

  context 'bought_price' do
    it '1, must be greater than or equal to 0' do
      expect(transaction.bought_price).to be >= 0
    end
    it '2, should be some type of Number' do
      expect(transaction.bought_price).to be_a BigDecimal || Integer
    end
    it '3, must have a value' do
      expect(transaction.bought_price).to_not be_nil
    end
  end

  context 'quantity' do
    it '1, must be greater than or equal to 0' do
      expect(transaction.quantity).to be >= 0
    end
    it '2, mmust be transaction_type Integer' do
      expect(transaction.quantity).to be_an Integer
    end
    it '3, must have a value' do
      expect(transaction.quantity).to_not be_nil
    end
  end
end
