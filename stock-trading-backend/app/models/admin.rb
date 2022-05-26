class Admin < Account
  protected

  def create_trader
    Trader.new(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      password: Faker::Internet.password
    )
  end
end
