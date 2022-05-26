class AdminController < ApplicationController
  before_action :authenticate_account!
  before_action :admin?

  private

  def admin?
    current_account.role == 'admin'
  end
end
