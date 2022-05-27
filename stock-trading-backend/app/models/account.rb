class Account < ApplicationRecord
  has_many :transactions

  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, :password, length: {
    minimum: 3,
    maximum: 20
  }

  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i },
            uniqueness: true

  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable,
         :registerable,
         :validatable,
         :confirmable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self
end
