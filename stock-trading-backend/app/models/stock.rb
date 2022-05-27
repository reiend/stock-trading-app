class Stock < ApplicationRecord
  validates :company_name, :symbol, :current_price, :change_percent, :quantity, presence: true
  validates :company_name, :symbol, uniqueness: true
  validates :current_price, :quantity, comparison: { greater_than_or_equal_to: 0 }
end
