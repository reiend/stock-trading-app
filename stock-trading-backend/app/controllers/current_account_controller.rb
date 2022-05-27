class CurrentAccountController < ApplicationController
  before_action :authenticate_account!
  before_action :trader_approved?

  def index
    render json: current_account
  end

  def stocks_bought
    if current_account.role == 'trader'
      render json: current_account.transactions.where(transaction_type: 'buy')
    else
      render json: {
        status: '401',
        message: 'account role must be trader'
      }
    end
  end

  def stocks_sold
    if current_account.role == 'trader'
      render json: current_account.transactions.where(transaction_type: 'sold')
    else
      render json: {
        status: '401',
        message: 'account role must be trader'
      }
    end
  end

  def transactions
    if current_account.role == 'trader'
      render json: current_account.transactions
    else
      render json: {
        status: '401',
        message: 'account role must be trader'
      }
    end
  end

  def trader_list
    if current_account.role == 'admin'
      render json: Account.all.where(role: 'trader')
    else
      render json: {
        status: '401',
        message: 'account role must be admin'
      }
    end
  end

  private

  def trader_approved?
    if current_account.role == 'trader' && !current_account.is_approved
      render json: {
        status: 401,
        message: 'trader account needs admin approval'
      }
    end
  end
end
