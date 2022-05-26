class CurrentAccountController < ApplicationController
  before_action :authenticate_account!

  def index
    render json: current_account
  end

  def stocks_bought
    if current_account.role == 'trader'
      render json: current_account.transactions.where(transaction_type: "buy")
    end
  end

  def stocks_sold
    if current_account.role == "trader"
      render json: current_account.transactions.where(transaction_type: "sold")
    end
  end

  def transactions
    if current_account.role == "trader"
      render json: current_account.transactions
    end
  end
end
