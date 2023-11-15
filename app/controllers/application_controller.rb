# TODO: Change the app for an API one
# class ApplicationController < ActionController::API

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization
  include ResponseHelper
  respond_to :json, :html

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery unless: -> { request.format.json? }
  # protect_from_forgery with: :null_session

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_json_parse_errors

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    # flash[:alert] = t("flash.pundit.unauthorized")
    redirect_back(fallback_location: root_path)
  end

  def handle_json_parse_errors
    # binding.pry
    render_unprocessable_entity_response("Invalid JSON: #{request.body.read}")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username phone_number age_group terms_of_service])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password remember_me])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:username, :password, :phone_number, :age_group, :remember_me, {
                                        profile: %i[avatar_url bio first_name last_name sex birth_date verified interests languages status],
                                        location: %i[country state city zip_code address],
                                        social_links: %i[facebook twitter instagram linkedin youtube]
                                      }])
  end
end

# https://stackoverflow.com/questions/35181340/rails-cant-verify-csrf-token-authenticity-when-making-a-post-request
