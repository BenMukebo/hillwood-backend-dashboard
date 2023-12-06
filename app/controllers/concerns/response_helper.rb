# rubocop: disable Style/HashSyntax
module ResponseHelper
  def render_success_response(message, data)
    render json: {
      success: true, # status: 'SUCCESS'
      successCode: 200,
      message: message,
      data: data,
      currentPage: 1,
      # perPage: 10,
      totalPage: 1
    }, status: :ok
  end

  def render_not_found_response(message)
    render json: {
      success: false,
      statusCode: 404,
      message: message,
      data: nil
    }, status: :not_found
  end

  def render_error_response(error)
    render json: {
      success: false,
      message: error.message,
      errors: error.data,
      data: nil
    }, status: error.status
  end

  def render_unprocessable_entity_response(error = 'Unprocessable entity')
    render json: {
      success: false,
      statusCode: 422,
      errors: error
    }, status: :unprocessable_entity
  end

  def render_unauthorized_response(message = 'Unauthorized')
    render json: {
      success: false,
      statusCode: 401,
      message: message,
      data: nil
    }, status: :unauthorized
  end

  def render_argument_error_response(error = 'Argument error')
    render json: {
      success: false,
      statusCode: 400,
      errors: error
    }, status: :bad_request
  end

  def render_no_content_response(message)
    render json: {
      success: true,
      successCode: 204,
      message: message,
      data: nil
    }, status: 201
  end

  def render_bad_request_response(message)
    render json: {
      success: false,
      statusCode: 400,
      message: message,
      data: nil
    }, status: :bad_request
  end

  def render_missing_token_response(message = 'Missing token')
    render json: {
      success: false,
      message: message,
      statusCode: 401,
      data: nil
    }, status: :unauthorized
  end

  def render_expired_token_response(message = 'Expired token')
    render json: {
      success: false,
      message: message,
      data: nil
    }, status: :unauthorized
  end
end
# rubocop: enable Style/HashSyntax

# rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_json_parse_errors
# before_action :handle_json_parse_errors, if: :json_request?

# def json_request?
#   request.format.json?
# end

# rescue_from ApiError do |exception|
#   log_error(exception)
#   render json: { error: exception.message }, status: exception.status
# end
