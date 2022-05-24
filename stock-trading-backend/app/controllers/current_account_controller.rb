class CurrentAccountController < ApplicationController
  before_action :authenticate_account!

  def index
    render json: current_account
  end

  # stocks_bought
  # stocks_sold
  # transactions
end
