class Api::MovieOutcastsController < Api::ApiController
  before_action :set_movie_outcast, only: %i[show update destroy]

  def index
    @movie_outcasts = MovieOutcast.all

    render_success_response('Outcasts movie fetched successfully', @movie_outcasts,
                            serializer: MovieOutcasts::MovieOutcastSerializer)
  end

  def options
    @movie_outcasts = MovieOutcast.all

    render_success_response('Outcasts movie options', @movie_outcasts,
                            serializer: MovieOutcasts::MovieOutcastOptionSerializer)
  end

  def show
    render_show_response('Outcast fetched successfully', @movie_outcast,
                         serializer: MovieOutcasts::MovieOutcastSerializer)
  end

  def create
    @movie_outcast = MovieOutcast.new(movie_outcast_params)

    if @movie_outcast.save
      render_show_response('Outcast created successfully', @movie_outcast,
                           serializer: MovieOutcasts::MovieOutcastSerializer,
                           location: api_movie_outcast_url(@movie_outcast))
    else
      render json: @movie_outcast.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie_outcast.update(movie_outcast_params)
      render_show_response('Outcast updated successfully', @movie_outcast,
                           serializer: MovieOutcasts::MovieOutcastSerializer,
                           location: api_movie_outcast_url(@movie_outcast))
    else
      render json: @movie_outcast.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie_outcast.destroy
  end

  private

  def set_movie_outcast
    @movie_outcast = MovieOutcast.find(params[:id])
  end

  def movie_outcast_params
    params.require(:movie_outcast).permit(
      :avatar_url, :first_name, :last_name, :status, { personal_details:
      %i[address bio date_of_birth first_name last_name phone_number interests languages sex] }
    )
  end
end
