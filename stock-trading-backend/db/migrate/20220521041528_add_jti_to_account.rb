class AddJtiToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :jti, :string
    add_index :accounts, :jti
  end
end
