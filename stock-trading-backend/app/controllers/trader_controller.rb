# frozen_string_literal: true

# TraderController's Template
class TraderController < ApplicationController
  before_action :authenticate_account!
  before_action :trader_approved?

  # TODO: cleanups

  def buy
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

    stock_json = Stock.where(symbol:).as_json
    stock = Stock.where(symbol:)
    is_stock_exist = !stock_json.empty?

    unless is_stock_exist
      render json: {
        status: 400,
        message: "Stock doesn\'t exist"
      }
      return
    end

    is_stock_empty = stock_json.first['quantity'] <= 0
    stock_quantity = stock_json.first['quantity']
    account_balance = current_account.balance
    is_low_stock = stock_quantity < quantity
    is_afford = (account_balance > (bought_price * quantity))

    if is_stock_empty
      render json: {
        status: 400,
        message: 'stock is empty'
      }
      return
    end

    if is_low_stock
      render json: {
        status: 400,
        message: 'not enough stock'
      }
      return
    end

    unless is_afford
      render json: {
        status: 400,
        message: 'Insufficient balance'
      }
      return
    end

    transaction_buy_json = current_account.transactions.where(transaction_type:, symbol:, bought_price:).as_json
    transaction_buy = current_account.transactions.where(transaction_type:, symbol:, bought_price:)
    has_same_stock_bought_price = transaction_buy.length > 0

    if has_same_stock_bought_price
      previous_quantity = transaction_buy_json.first['quantity']

      # increase same bought_price quantity on buy transaction_buy
      transaction_buy.update(quantity: previous_quantity + quantity)

      # after buying a stock deduc the price on account balance
      current_account.update_columns(balance: account_balance.to_d - (quantity.to_i * bought_price.to_d))

      # after buying a stock reduce stock's stock/quantity
      stock.where(symbol:).update(quantity: stock_quantity.to_i - quantity.to_i)

      render json: {
        status: 200,
        message: 'successfully bought a stock',
        account: current_account,
        transaction: transaction_buy
      }
      nil

    else
      new_transaction = current_account.transactions.create!(
        stock_name:,
        symbol:,
        quantity:,
        bought_price:,
        transaction_type:
      )

      # increase same bought_price quantity on buy transaction_buy
      transaction_buy.update(quantity:)

      # after buying a stock deduc the price on account balance
      current_account.update_columns(balance: account_balance.to_d - bought_price.to_d)

      # after buying a stock reduce stock's stock/quantity
      stock.where(symbol:).update(quantity: stock_quantity.to_i - quantity.to_i)

      render json: {
        status: 201,
        message: 'successfully bought a stock',
        account: current_account,
        transaction: new_transaction
      }
      nil
    end
  rescue StandardError
    render json: {
      status: 500,
      message: 'something went wrong'
    }
  end

  def sell
    begin
      id,
      stock_name,
      symbol,
      quantity,
      bought_price,
      transaction_type = transaction_params
                         .values_at(
                           :id,
                           :stock_name,
                           :symbol,
                           :quantity,
                           :bought_price,
                           :transaction_type
                         )
      stock_json = current_account.transactions.where(transaction_type: 'buy', symbol:, id:).as_json
      stock = current_account.transactions.where(transaction_type: 'buy', symbol:, id:)
      is_stock_exist = !stock_json.empty?

      unless is_stock_exist
        render json: {
          status: 400,
          message: "You don\'t own this stock"
        }
        return
      end

      stock_quantity = stock_json.first['quantity']
      is_stock_empty = stock_quantity <= 0

      if is_stock_empty
        render json: {
          status: "400",
          message: "you don\'t have any stock left or it\'s invalid stock bought ID"
        }
        return
      end

      if quantity > stock_quantity
        render json: {
          status: "400",
          message: "you don\'t have enught stock to sell"
        }
        return
      end

      transaction_buy_json = current_account.transactions.where(transaction_type: 'buy', symbol:, id:).as_json
      transaction_buy = current_account.transactions.where(transaction_type: 'buy', symbol:, id:)
      has_transactions_buy = transaction_buy.length > 0

      previous_quantity_buy = transaction_buy_json.first['quantity']

      new_transaction = current_account.transactions.create!(
        stock_name:,
        symbol:,
        quantity:,
        bought_price:,
        transaction_type:
      )

      transaction_sell = current_account.transactions.where(transaction_type:, symbol:, bought_price:)
      new_bought_stock_quantity = previous_quantity_buy.to_i - quantity.to_i

      transaction_buy.update(quantity: new_bought_stock_quantity)

      updated_stock = Stock.where(symbol:)

      updated_stock.where(symbol:).update(quantity: updated_stock.first['quantity'].to_i + quantity.to_i)

      current_account.update_columns(balance: current_account.balance + (quantity * bought_price.to_d))

      render json: {
        status: 201,
        account: current_account,
        message: 'successfully sell a stock',
        transaction: transaction_sell
      }
    rescue StandardError
      render json: {
        status: 500,
        message: 'something went wrong'
      }
    end
  end

  private

  def transaction_params
    params
      .require(:transaction)
      .permit(
        :id,
        :stock_name,
        :symbol,
        :quantity,
        :bought_price,
        :transaction_type
      )
  end

  def trader_approved?
    if current_account.role == 'trader' && !current_account.is_approved
      render json: {
        status: 401,
        message: 'trader account needs admin approval'
      }
    end
  end
end
