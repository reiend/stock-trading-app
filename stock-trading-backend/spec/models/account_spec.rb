require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account_test1) do
    Account.new(
      first_name: 'account',
      last_name: 'test1',
      user_name: 'account_test1'
    )
  end

  context 'Additional Attributes' do
    context 'first_name' do
      it '1, shouldn\'t be empty' do
        expect(account_test1.first_name).to_not be_nil
      end
      it '2, must be type string' do
        expect(account_test1.first_name).to be_a String
      end
      it '3, length should be less than 20 but greater than equal 3' do
        expect(account_test1.first_name.size).to be <= 20 && be >= 3
      end
    end

    context 'last_name' do
      it '1, shouldn\'t be empty' do
        expect(account_test1.last_name).to_not be_nil
      end
      it '2, must be type string' do
        expect(account_test1.last_name).to be_a String
      end
      it '3, length should be less than 20 but greater than equal 3' do
        expect(account_test1.last_name.size).to be <= 20 && be >= 3
      end
    end

    context 'user_name' do
      it '1, shouldn\'t be empty' do
        expect(account_test1.user_name).to_not be_nil
      end
      it '2, must be type string' do
        expect(account_test1.user_name).to be_a String
      end
      it '3, length should be less than 20 but greater than equal 3' do
        expect(account_test1.user_name.size).to be <= 20 && be >= 3
      end
    end
  end
end
