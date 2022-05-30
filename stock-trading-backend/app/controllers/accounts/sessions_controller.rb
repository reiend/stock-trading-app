# frozen_string_literal: true

# Accounnt:SessionController's Template
class Accounts::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in sucessfully.' },
      data: AccountSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
    render json: {
      status: 200,
      message: 'logged out successfully'
    }, status: :ok
  end
end
