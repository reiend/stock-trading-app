# frozen_string_literal: true

# ApplicationController's Template
class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer
      .permit(
        :sign_up,
        keys: %i[first_name last_name user_name]
      )
  end
end
