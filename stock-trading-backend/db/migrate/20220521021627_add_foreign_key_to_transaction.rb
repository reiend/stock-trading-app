class AddForeignKeyToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :transactions, :accounts
  end
end
