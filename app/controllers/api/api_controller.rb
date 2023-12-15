# TODO: Change the app for an API one
# class ApplicationController < ActionController::API

class Api::ApiController < ActionController::Base
  include ResponseHelper


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ArgumentError, with: :argument_error
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

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    # flash[:alert] = t("flash.pundit.unauthorized")
    redirect_back(fallback_location: root_path)
  end

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
end

# https://stackoverflow.com/questions/35181340/rails-cant-verify-csrf-token-authenticity-when-making-a-post-request
