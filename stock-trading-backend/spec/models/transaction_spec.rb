require 'rails_helper'

RSpec.describe Transaction, type: :model do
  # Transactions
  let(:transaction) do
    Transaction.new(
      transaction_type: 'buy',
      stock_name: 'Tesla',
      quantity: 2
    )
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
  end

  context 'quantity' do
    it '1, must be greater than or equal to 0' do
      expect(transaction.quantity).to be >= 0
    end
    it '2, mmust be transaction_type Integer' do
      expect(transaction.quantity).to be_an Integer
    end
  end
end
