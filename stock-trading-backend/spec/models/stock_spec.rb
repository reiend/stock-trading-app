# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Stock's Model", type: :model do
  # Stocks
  # Tesla
  let(:stock1) do
    Stock.new(
      company_name: 'Tesla',
      symbol: 'Tesla',
      quantity: 5,
      current_price: 150.25,
      change_percent: 0.0245
    )
  end

  let(:stock2) do
    Stock.new(
      company_name: 'Microsoft',
      symbol: 'Microsoft',
      quantity: 1,
      current_price: 250.25,
      change_percent: 0.0445
    )
  end

  context 'company_name' do
    it '1, must be unique' do
      expect(stock1.company_name).to_not eq(stock2.company_name)
    end
    it '2, must be type String' do
      expect(stock1.company_name).to be_a String
    end
    it '3, must have a value' do
      expect(stock1.company_name).to_not be_nil
    end
  end
  context 'symbol' do
    it '1, must be unique' do
      expect(stock1.symbol).to_not eq(stock2.symbol)
    end
    it '2, must be type String' do
      expect(stock1.symbol).to be_a String
    end
    it '3, must have a value' do
      expect(stock1.symbol).to_not be_nil
    end
  end
  context 'quantity' do
    it '1, must be greater than or equal to 0' do
      expect(stock1.quantity).to be >= 0
    end
    it '2, must be type Integer' do
      expect(stock1.quantity).to be_an Integer
    end
    it '3, must have a value' do
      expect(stock1.quantity).to_not be_nil
    end
  end
  context 'current price' do
    it '1, must be greater than or equal to 0' do
      expect(stock1.current_price).to be >= 0
    end
    it '2, should be some type of Number' do
      expect(stock1.current_price).to be_a BigDecimal || Integer
    end
    it '3, must have a value' do
      expect(stock1.current_price).to_not be_nil
    end
  end

  context 'change percent' do
    it '1, should be some type of Number' do
      expect(stock1.change_percent).to be_a BigDecimal || Integer
    end
    it '2, must have a value' do
      expect(stock1.change_percent).to_not be_nil
    end
  end
end
