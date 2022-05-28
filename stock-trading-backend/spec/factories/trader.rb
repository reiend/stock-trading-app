FactoryBot.define do
  factory :trader do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    # role -> trader by default
  end
end
