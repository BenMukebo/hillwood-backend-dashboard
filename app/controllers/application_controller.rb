class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery unless: -> { request.format.json? }
  # protect_from_forgery with: :null_session

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    # flash[:alert] = t("flash.pundit.unauthorized")
    redirect_back(fallback_location: root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username phone age_group terms_of_service])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
    # devise_parameter_sanitizer.permit(:account_update,
    #                                   keys: [:username, :phone, :age_group, :remember_me,
    #                                          { address_attributes: %i[country state city area postal_code],
    #                                           profile: %i[first_name last_name sex age phone location profession] }])
  end
end

# https://stackoverflow.com/questions/35181340/rails-cant-verify-csrf-token-authenticity-when-making-a-post-request
