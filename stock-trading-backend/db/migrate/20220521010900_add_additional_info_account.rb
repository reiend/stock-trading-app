# frozen_string_literal: true

# AddAdditionalInfoAccount's migration template
class AddAdditionalInfoAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
    add_column :accounts, :role, :string
    add_column :accounts, :balance, :decimal
  end
end
