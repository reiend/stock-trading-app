class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :company_name
      t.string :symbol
      t.decimal :current_price
      t.decimal :change_percent
      t.integer :quantity

      t.timestamps
    end
  end
end
