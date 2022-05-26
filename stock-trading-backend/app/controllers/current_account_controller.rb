class CurrentAccountController < ApplicationController
  before_action :authenticate_account!

  def index
    render json: current_account
  end

  def stocks_bought
    if current_account.role == 'trader'
      render json: current_account.transactions.where(transaction_type: 'buy')
    else
      render json: {
        message: 'account role must be trader'
      }
    end
  end

  def stocks_sold
    if current_account.role == 'trader'
      render json: current_account.transactions.where(transaction_type: 'sold')
    else
      render json: {
        message: 'account role must be trader'
      }
    end
  end

  def transactions
    if current_account.role == 'trader'
      render json: current_account.transactions
    else
      render json: {
        message: 'account role must be trader'
      }
    end
  end

  def trader_list
    if current_account.role == 'admin'
      render json: Account.all.where(role: 'trader')
    else
      render json: {
        message: 'account role must be admin'
      }
    end
  end
end
