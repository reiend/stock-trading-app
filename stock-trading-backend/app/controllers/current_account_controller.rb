class CurrentAccountController < ApplicationController
  before_action :authenticate_account!

  def index
    render json: current_account
  end
end
