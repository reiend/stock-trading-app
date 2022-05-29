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

  def traders_pending
    render json: {
      status: 200,
      message: 'Successfully render all pending trader',
      pending_approvals: Account.all.where(is_approved: nil, role: 'trader')
    }
  end

  def trader
    begin
      admin_id = 1
      @trader = Account.find(specific_trader_params[:id])

      if @trader.id == admin_id
        render json: {
          status: 200,
          message: 'invalid id, start with 2'
        }
        return
      end

      render json: {
        status: 200,
        message: 'successfully get a trader',
        trader: @trader
      }
    rescue
      render json: {
        status: 401,
        message: 'trader can\'t be found',
      }
    end
  end

  def approve
    @account = Account.find(params[:id])

    if @account.is_approved
      @account.update_columns(is_approved: true)

      render json: {
        status: 201,
        message: 'Successfully approved trader',
        trader: @account
      }
    else
      render json: {
        status: 401,
        message: 'account trader must be approved first'
      }
    end
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: 401,
      message: 'something went wrong'
    }
  end

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

  def specific_trader_params
    params
      .require(:account)
      .permit(
        :id
      )
  end
end
