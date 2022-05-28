class Transaction < ApplicationRecord
  belongs_to :account
  validates :stock_name, :symbol, :transaction_type, :bought_price, :quantity, presence: true
  validates :bought_price, :quantity, comparison: { greater_than_or_equal_to: 0 }
end
