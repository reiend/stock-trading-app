# frozen_string_literal: true

# TraderController's Template
class TraderController < ApplicationController
  # TODO: cleanups

  # buy
  def buy

    begin

      stock_name,
      symbol,
      quantity,
      bought_price,
      transaction_type = transaction_params
                         .values_at(
                           :stock_name,
                           :symbol,
                           :quantity,
                           :bought_price,
                           :transaction_type
                         )

      total_bought_price = quantity.to_i * bought_price.to_d
      stock = Stock.where(symbol:).as_json
      is_stock_exist = Stock.where(symbol:).length <= 0
      has_stock = stock.first['quantity'] >= quantity
      has_balance = (stock.first['current_price'].to_d <= total_bought_price) && (total_bought_price <= current_account.balance)
      account_bought_stock = current_account.transactions.where(transaction_type: 'buy', symbol:).as_json
      account_no_stock_bought = current_account.transactions.where(transaction_type:, symbol:).empty?

      if is_stock_exist
        render json: {
          status: 401,
          message: "stock doesn\'t exist"
        }
        return
      end

      unless has_stock
        render json: {
          status: 401,
          message: 'Out of stock'
        }
        return
      end

      unless has_balance
        render json: {
          status: 401,
          message: 'Insufficient Balance'
        }
        return
      end

      if account_no_stock_bought
        stock_quantity = stock.first['quantity']
        previous_account_balance = current_account.balance

        current_account.transactions.create(
          stock_name:,
          symbol:,
          quantity:,
          transaction_type:,
          bought_price:
        )

        Stock.where(symbol:)
             .update(quantity: stock_quantity - quantity)

        current_account
          .update_columns(balance: previous_account_balance.to_d - bought_price.to_d)

        render json: {
          status: 200,
          message: 'successfully bought a stock',
          account: current_account,
          transaction: current_account.transactions.where(transaction_type:, symbol:)
        }
      else
        stock_quantity = stock.first['quantity']
        account_bought_stock_quantity = account_bought_stock.first['quantity']
        previous_account_balance = current_account.balance

        current_account.transactions.where(transaction_type:, symbol:)
                       .update(quantity: quantity + account_bought_stock_quantity)

        Stock.where(symbol:)
             .update(quantity: stock_quantity - quantity)

        current_account
          .update_columns(balance: previous_account_balance.to_d - bought_price.to_d)

        render json: {
          status: 201,
          message: 'successfully bought a stock',
          account: current_account,
          transaction: current_account.transactions.where(transaction_type:, symbol:)
        }
        nil
      end
    rescue
      render json: {
        status: 400,
        message: "something went wrong",
      }
    end
  end

  # sell

  private

  def transaction_params
    params
      .require(:transaction)
      .permit(
        :stock_name,
        :symbol,
        :quantity,
        :bought_price,
        :transaction_type
      )
  end
end
