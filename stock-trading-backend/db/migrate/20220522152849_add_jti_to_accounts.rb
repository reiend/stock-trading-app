# frozen_string_literal: true

# AddJtiToAccounts migration template
class AddJtiToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :jti, :string
    add_index :accounts, :jti
  end
end
