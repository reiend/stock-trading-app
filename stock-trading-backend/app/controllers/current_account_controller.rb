# frozen_sring_literal: true

# CurrentAccountController's Template
class CurrentAccountController < ApplicationController
  before_action :authenticate_account!
  before_action :trader_approved?

  def index
    render json: current_account
  end

  def stocks_bought
    if current_account.role == 'trader'
      transactions_buy = current_account.transactions.where(transaction_type: 'buy')

      total_bought_stock = 0
      transactions_buy.each do |stock_bought|
        total_bought_stock += (stock_bought['bought_price'] * stock_bought['quantity'])
      end

      render json: {
        status: '200',
        message: 'successfully render all bought stock grater than zero',
        total_bought: total_bought_stock,
        transactions: transactions_buy
      }
    else
      render json: {
        status: '401',
        message: 'account role must be trader'
      }
    end
  end

  def stocks_sold
    if current_account.role == 'trader'
      transactions_sell = current_account.transactions.where(transaction_type: 'sell')

      total_sold_stock = 0
      transactions_sell.each do |stock_sold|
        total_sold_stock += (stock_sold['bought_price'] * stock_sold['quantity'])
      end

      render json: {
        status: '200',
        message: 'successfully render all bought stock grater than zero',
        total_sold: total_sold_stock,
        transactions: transactions_sell
      }

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
