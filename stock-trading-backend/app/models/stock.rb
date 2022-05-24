class Stock < ApplicationRecord
  validates :company_name, :current_price, :change_percent, :quantity, presence: true
  validates :company_name, uniqueness: true
  validates :current_price, :quantity, comparison: { greater_than_or_equal_to: 0 }
end
