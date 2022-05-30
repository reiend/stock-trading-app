# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create default admin Account
admin = Account.create!(
  first_name: 'admin',
  last_name: 'admin',
  email: 'admin@gmail.com',
  password: 'admin12345',
  role: 'admin'
)

admin.confirm!

IEX::Api::Client.new(
  publishable_token: 'pk_9d26176d72f845e7ad03a261815928c5',
  secret_token: 'secret_token',
  endpoint: 'https://cloud.iexapis.com/v1'
).stock_market_list(:mostactive).each do |stock|
  Stock.create!(
    company_name: stock.company_name,
    symbol: stock.symbol,
    current_price: stock.latest_price,
    change_percent: stock.change_percent,
    quantity: Faker::Number.between(from: 1, to: 10)
  )
end
