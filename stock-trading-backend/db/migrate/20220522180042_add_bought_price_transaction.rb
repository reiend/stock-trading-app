class AddBoughtPriceTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :bought_price, :decimal
  end
end
