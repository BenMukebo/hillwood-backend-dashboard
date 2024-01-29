class Api::OutcastsController < Api::ApiController
  before_action :set_outcast, only: %i[show update destroy]

  def index
    @outcasts = outcast_scope

    render_success_response('Outcasts fetched successfully', @outcasts, serializer: Outcasts::OutcastSerializer)
  end

  def options
    @search = search_params[:search]
    @outcasts = @search.present? ? outcast_scope.search_by_name(@search) : outcast_scope

    if @outcasts.any?
      render_success_response('Outcasts options', @outcasts, serializer: Outcasts::OutcastOptionSerializer)
    else
      render_success_response("No outcasts #{@search} found in the DB", @outcasts, serializer: Outcasts::OutcastOptionSerializer)
    end
  end

  def show
    render_show_response('Outcast fetched successfully', @outcast, serializer: Outcasts::OutcastSerializer)
  end

  def create
    @outcast = Outcast.new(outcast_params)

    if @outcast.save
      render_show_response('Outcast created successfully', @outcast, serializer: Outcasts::OutcastSerializer,
                                                                     location: api_outcast_url(@outcast))
    else
      render json: @outcast.errors, status: :unprocessable_entity
    end
  end

  def update
    if @outcast.update(outcast_params)
      # render :show, status: :ok, location: @outcast
      render_show_response('Outcast updated successfully', @outcast, serializer: Outcasts::OutcastSerializer,
                                                                     location: api_outcast_url(@outcast))
    else
      render json: @outcast.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @outcast.destroy
  end

  private

  def outcast_scope
    Outcast.all.includes(:movies, :series)
  end

  def set_outcast
    @outcast = Outcast.find(params[:id])
  end

  def search_params
    params.permit(:keyword, :page, :per_page, :search, :status)
  end

  def outcast_params
    params.require(:outcast).permit(:avatar_url, :first_name, :last_name, :date_of_birth, :personal_details, :status)
  end
end
