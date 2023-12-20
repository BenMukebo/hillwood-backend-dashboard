module Api
  class ApiController < ApplicationController # ActionController::Base
    # skip_before_action :verify_authenticity_token
    include DeviseTokenAuth::Concerns::SetUserByToken
    # include Devise::Controllers::Helpers
    # include ActionController::Helpers       # FIXES undefined method `helper' for ActiveAdmin::Devise::SessionsController:Class (NoMethodError)
    include ResponseHelper
    respond_to :json

    # before_action :authenticate_user!, unless: :devise_controller?
    before_action :authenticate_api_user!, unless: :devise_controller?

    before_action :configure_permitted_parameters, if: :devise_controller?

    protect_from_forgery unless: -> { request.format.json? }
    # protect_from_forgery with: :null_session

    rescue_from ArgumentError, with: :argument_error
    # rescue_from ActionController::ParameterMissing, with: :argument_error
    # rescue_from ActionDispatch::Http::Parameters::ParseError, with: :argument_error
    # TODO fix ActionDispatch::Http::Parameters::ParseError (795: unexpected token at ''):
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
    rescue_from ActiveRecord::RecordNotSaved, with: :record_not_saved
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
    rescue_from ActionController::UnpermittedParameters, with: :unpermitted_parameters
    rescue_from ActionController::ParameterMissing, with: :parameter_missing

    private

    def argument_error(error)
      render_argument_error_response("Argument Error: #{error.message}")
      # render_unprocessable_entity_response('Argument Error: ' + error.message)
    end

    def record_not_found(error)
      render_not_found_response(error.message)
    end

    def record_not_destroyed(error)
      render_unprocessable_entity_response(error.message)
    end

    def record_invalid(error)
      render_unprocessable_entity_response(error.message)
    end

    def record_not_unique(error)
      render_unprocessable_entity_response(error.message)
    end

    def record_not_saved(error)
      render_unprocessable_entity_response(error.message)
    end

    def unpermitted_parameters(error)
      render_unprocessable_entity_response(error.message)
    end

    def parameter_missing(error)
      render_unprocessable_entity_response(error.message)
    end

    protected

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
end
