# frozen_string_literal: true

# CreateTransactions migration template
class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :stock_name
      t.string :transaction_type
      t.decimal :bought_price
      t.integer :quantity

      t.timestamps
    end
  end
end
