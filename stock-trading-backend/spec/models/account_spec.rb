require 'rails_helper'

RSpec.describe "Account's Model", type: :model do
  # trader
  let(:account_trader1) do
    Account.new(
      first_name: 'account',
      last_name: 'test1',
      balance: 2500.25,
      role: 'trader'
    )
  end
  # admin
  let(:account_admin) { Account.new(role: 'admin') }
  let(:account_admin_dummy) { Account.new(role: 'role_should_be_not_admin') }

  it '1, should have_many transactions' do
    transactions = Account.reflect_on_association(:transactions)
    expect(transactions.macro).to eq(:has_many)
  end
  context 'Additional Attributes' do
    context 'Trader' do
      context 'first_name' do
        it '1, shouldn\'t be empty' do
          expect(account_trader1.first_name).to_not be_nil
        end
        it '2, must be type string' do
          expect(account_trader1.first_name).to be_a String
        end
        it '3, length should be less than 20 but greater than equal 3' do
          expect(account_trader1.first_name.size).to be <= 20 && be >= 3
        end
        it '4, must have a value' do
          expect(account_trader1.first_name).to_not be_nil
        end
      end

      context 'last_name' do
        it '1, shouldn\'t be empty' do
          expect(account_trader1.last_name).to_not be_nil
        end
        it '2, must be type string' do
          expect(account_trader1.last_name).to be_a String
        end
        it '3, length should be less than 20 but greater than equal 3' do
          expect(account_trader1.last_name.size).to be <= 20 && be >= 3
        end
        it '4, must have a value' do
          expect(account_trader1.last_name).to_not be_nil
        end
      end

      context 'balance' do
        it '1, must be greater than or equal to zero' do
          expect(account_trader1.balance).to be >= 0
        end
        it '2, should be some type of Number' do
          puts account_trader1.balance.class
          expect(account_trader1.balance).to be_a BigDecimal || Integer
        end
      end

      context 'role' do
        it '1, shouldn\'t be equal to admin' do
          expect(account_trader1.role).to_not eq('admin')
        end
        it '2, must be trader' do
          expect(account_trader1.role).to eq('trader')
        end
      end
    end

    context 'Admin' do
      context 'role' do
        it '1, shouldn\'t be equal to trader' do
          expect(account_admin.role).to_not eq('trader')
        end
        it '2, must be admin' do
          expect(account_admin.role).to eq('admin')
        end
        it '3, there should be only one admin account' do
          expect(account_admin_dummy.role).to_not eq(account_admin.role)
        end
      end
    end
  end
end
