module Api
  class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    # include Devise::Controllers::Helpers
    # include ActionController::Helpers # `helper' for ActiveAdmin::Devise::SessionsController:Class (NoMethodError)
    # include ActionController::Serialization
    include ResponseHelper
    respond_to :json

    before_action :authenticate_api_user!, unless: :devise_controller?

    protect_from_forgery unless: -> { request.format.json? }
    # protect_from_forgery with: :null_session

    # TODO : fix ActionDispatch::Http::Parameters::ParseError (795: unexpected token at ''):
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
    rescue_from ActiveRecord::RecordNotSaved, with: :record_not_saved
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
    rescue_from ActionController::UnpermittedParameters, with: :unpermitted_parameters
    rescue_from ActionController::ParameterMissing, with: :parameter_missing

    private

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
  end
end
