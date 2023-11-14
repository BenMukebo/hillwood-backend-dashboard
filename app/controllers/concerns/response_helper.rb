# rubocop: disable Style/HashSyntax
module ResponseHelper
  def render_success_response(message, data)
    render json: {
      success: true, # status: 'SUCCESS'
      message: message,
      data: data
    }, status: :ok
  end

  def render_not_found_response(message)
    render json: {
      success: false,
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

  # unprocessable_entity
  def render_unprocessable_entity_response(error = 'Unprocessable entity')
    render json: {
      success: false,
      errors: error,
    }, status: :unprocessable_entity
  end

  def render_unauthorized_response(message = 'Unauthorized')
    render json: {
      success: false,
      message: message,
      data: nil
    }, status: :unauthorized
  end

  def render_missing_token_response(message = 'Missing token')
    render json: {
      success: false,
      message: message,
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
