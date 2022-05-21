class AddAdditionalInfoAccountDevise < ActiveRecord::Migration[7.0]
  def change
    add_column :account, :role, :string, :default: "trader"
    add_column :account, :first_name, :string, 
    add_column :account, :last_name, :string 
  end
end
