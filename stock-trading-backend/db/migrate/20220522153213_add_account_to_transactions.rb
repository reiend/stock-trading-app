# frozen_string_literal: true

# AddAccountToTransactions migration template
class AddAccountToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :account
  end
end
