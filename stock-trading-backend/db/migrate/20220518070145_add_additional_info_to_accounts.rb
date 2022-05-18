class AddAdditionalInfoToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
    add_column :accounts, :user_name, :string
  end
end
