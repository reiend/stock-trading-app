# frozen_string_literal: true

# AdminController's Template
class AdminController < ApplicationController
  before_action :authenticate_account!
  before_action :admin?

  def create
    @trader = Account.new(trader_params)
    if @trader.save
      render json: {
        status: 200,
        trader: @trader,
        message: 'successfully created a trader'
      }
    else
      render json: {
        status: 401,
        message: 'Something went wrong'
      }
    end
  end

  def approve; end

  private

  def admin?
    current_account.role == 'admin'
  end

  def trader_params
    params
      .require(:account)
      .permit(
        :first_name,
        :last_name,
        :email,
        :password
      )
  end
end
