class StockController < ApplicationController
  def list
    @stock_list = Stock.all

    render json: {
      status: '200',
      message: 'successfully view stock list',
      stock_list: @stock_list
    }
  end
end
