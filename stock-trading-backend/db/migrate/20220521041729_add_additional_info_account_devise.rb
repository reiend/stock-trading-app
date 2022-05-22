class AddAdditionalInfoAccountDevise < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :role, :string, :default: "trader"
    add_column :accounts, :first_name, :string, 
    add_column :accounts, :last_name, :string 
  end
end
