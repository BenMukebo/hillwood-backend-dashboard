# rubocop: disable Style/HashSyntax
module ResponseHelper
  require 'will_paginate/array'
  WillPaginate.per_page = 10 # set per_page globally

  # Query params: ?search, ?per_page, ?page

  def render_success_response(message, data, serializer: nil)
    current_page = params[:page] || 1
    items_per_page = params[:per_page] || WillPaginate.per_page

    # total_page ||= 1
    total_items = data.size || 0
    total_pages = total_items.positive? ? (total_items / items_per_page.to_f).ceil : 0

    # paginate_data = data.paginate(page: params[:page] || 1, per_page: items_per_page)
    serialized_data = serializer ? ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer).as_json : data
    @paginate_data = serialized_data.paginate(page: params[:page] || 1, per_page: items_per_page)

    render json: {
      success: true,
      # successCode: "S000",
      statusCode: 200,
      message: message,
      data: @paginate_data,
      currentPage: current_page.to_i,
      totalPages: total_pages,
      pageSize: @paginate_data.count,
      totalItems: total_items
    }, status: :ok
  end

  def render_show_response(message, data, serializer: nil, location: nil)
    response_hash = {
      success: true,
      # successCode: "S000",
      statusCode: 201,
      message: message,
      data: serializer ? ActiveModelSerializers::SerializableResource.new(data, serializer: serializer).as_json : data
    }

    # response_hash[:location] = location if location.present? # this add the location to both response header and body
    render json: response_hash, status: :ok
    response.headers['Location'] = location if location.present?
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
