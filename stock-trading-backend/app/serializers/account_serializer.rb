class AccountSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :first_name, :last_name, :balance, :email, :created_at
end
