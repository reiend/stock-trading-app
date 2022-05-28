# frozen_string_literal: true

# TraderController's Template
class TraderController < ApplicationController
  before_action :authenticate_account!
  before_action :admin?
  # TODO: cleanups

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

      stock_json = Stock.where(symbol:).as_json
      stock = Stock.where(symbol:)
      is_stock_exist = !stock_json.empty?
      is_stock_empty = stock_json.first["quantity"] <= 0
      stock_quantity = stock_json.first["quantity"]

      account_balance = current_account.balance
      is_afford = (account_balance > (bought_price * quantity))

      unless is_stock_exist
        render json: {
          status: 400,
          message: "Stock doesn\'t exist",
        }
        return
      end

      if is_stock_empty
        render json: {
          status: 400,
          message: "Stock is empty",
        }
        return
      end

      unless is_afford
        render json: {
          status: 400,
          message: "Insufficient balance",
        }
        return
      end

      transaction_buy_json = current_account.transactions.where(transaction_type:, symbol:, bought_price:).as_json
      transaction_buy = current_account.transactions.where(transaction_type:, symbol:, bought_price:)
      has_same_stock_bought_price = transaction_buy.length > 0
      previous_quantity = transaction_buy_json.first["quantity"]
      

      if has_same_stock_bought_price

        # increase same bought_price quantity on buy transaction_buy
        transaction_buy.update(quantity: previous_quantity + quantity)

        # after buying a stock deduc the price on account balance
        current_account.update_columns(balance: account_balance.to_d - (quantity.to_i * bought_price.to_d))

        # after buying a stock reduce stock's stock/quantity
        stock.where(symbol:).update(quantity: stock_quantity.to_i - quantity.to_i)

        render json: {
          status: 200,
          message: "successfully bought a stock",
          account: current_account,
          transaction: transaction_buy
        }

      else
       new_transaction = current_account.transactions.create!(
         stock_name:,
         symbol:,
         quantity:,
         bought_price:,
         transaction_type:,
       )

        # increase same bought_price quantity on buy transaction_buy
        transaction_buy.update(quantity: previous_quantity + quantity)

        # after buying a stock deduc the price on account balance
        current_account.update_columns(balance: account_balance.to_d - bought_price.to_d)

        # after buying a stock reduce stock's stock/quantity
        stock.where(symbol:).update(quantity: stock_quantity.to_i - quantity.to_i)

       render json: {
         status: 201,
         message: "successfully bought a stock",
         account: current_account,
         transaction: new_transaction
       }
      end


    rescue
      render json: {
        status: 400,
        message: "something went wrong",
      }
    end
  end


  def sell
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
      
      stock_json = current_account.transactions.where(transaction_type: "buy", symbol:).as_json
      stock = current_account.transactions.where(transaction_type: "buy", symbol:)
      is_stock_exist = !stock_json.empty?
      is_stock_empty = stock_json.first["quantity"] <= 0
      stock_quantity = stock_json.first["quantity"]

      unless is_stock_exist
        render json: {
          status: 400,
          message: "Stock doesn\'t exist",
        }
        return
      end

      if is_stock_empty
        render json: {
          status: 400,
          message: "Stock is empty",
        }
        return
      end

      transaction_buy_json = current_account.transactions.where(transaction_type: "buy", symbol:, bought_price:).as_json
      transaction_buy = current_account.transactions.where(transaction_type: "buy", symbol:, bought_price:)
      has_same_stock_bought_price = transaction_buy.length > 0
      previous_quantity_buy = transaction_buy_json.first["quantity"]

      if has_same_stock_bought_price

         new_transaction = current_account.transactions.create!(
           stock_name:,
           symbol:,
           quantity:,
           bought_price:,
           transaction_type:
         )

        transaction_sell_json = current_account.transactions.where(transaction_type:, symbol:, bought_price:).as_json
        transaction_sell = current_account.transactions.where(transaction_type:, symbol:, bought_price:)
        has_same_stock_sold_price = transaction_sell.length > 0
        previous_quantity_sell = transaction_sell_json.first["quantity"]
        new_bought_stock_quantity = previous_quantity_buy.to_i - quantity.to_i

        transaction_buy.update(quantity: new_bought_stock_quantity)

        updated_stock = Stock.where(symbol:)

        updated_stock.where(symbol:).update(quantity: updated_stock.first["quantity"].to_i + quantity.to_i)

        current_account.update_columns(balance: current_account.balance + (quantity * bought_price.to_d))

        render json: { 
          status: 201,
          account: current_account,
          message: "successfully sell a stock",
          transaction: transaction_sell,
        }

        return
      else
        render json: { 
          status: 201,
          message: "Insufficient Stocks' stock",
        }
        return
      end

    rescue
      render json: {
        status: 400,
        message: "something went wrong",
      }
    end
  end

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
