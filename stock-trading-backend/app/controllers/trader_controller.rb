# frozen_string_literal: true

# TraderController's Template
class TraderController < ApplicationController
  # callback here after_save or before save
  # callback differs on transaction_type

  # buy
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

    current_transaction = current_account.transactions.create(
      stock_name:,
      symbol:,
      quantity:,
      bought_price:,
      transaction_type:
    )

    current_transaction.save

    render json: {
      status: 201,
      message: 'successfully bought a stock',
      transaction: current_transaction,
      transactions: current_account.transactions,
    }

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

  def transaction_buy

  end
end
