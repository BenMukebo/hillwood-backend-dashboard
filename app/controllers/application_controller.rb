class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  # include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization
  include ResponseHelper
  respond_to :json, :html

  # before_action :configure_permitted_parameters, if: :devise_controller?

  # protect_from_forgery unless: -> { request.format.json? }
  # protect_from_forgery with: :null_session

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # def user_not_authorized
  #   # flash[:alert] = 'You are not authorized to perform this action.'
  #   # flash[:alert] = t("flash.pundit.unauthorized")
  #   # redirect_back(fallback_location: root_path)
  # end

  protected

  # def authenticate_user!
  #   redirect_to root_path, notice: 'Please sign in' unless user_signed_in?
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username phone_number age_group terms_of_service])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password remember_me welcome_email_send])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:username, :password, :phone_number, :age_group, :verification_status,
                                             {
                                               profile: %i[
                                                 avatar_url bio first_name last_name sex phone_verified date_of_birth interests languages
                                               ],
                                               locations: %i[country state city address zip_code countryIsoCode stateIsoCode],
                                               social_links: %i[facebook twitter instagram linkedin youtube]
                                             }])
  end
end

# https://stackoverflow.com/questions/35181340/rails-cant-verify-csrf-token-authenticity-when-making-a-post-request
