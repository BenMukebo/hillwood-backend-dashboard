class Api::MoviesController < Api::ApiController
  before_action :set_movie, only: %i[show update destroy]

  def index
    @movies = if params[:search].present?
                Movie.includes(:movie_genre).where('name LIKE :search', search: "%#{params[:search]}%")
              else
                Movie.includes(:movie_genre).all.to_a
              end

    # Check if movies are present
    if @movies.any?
      render_success_response('Movies fetched successfully', @movies, serializer: Movies::MovieSerializer)
    elsif params[:search].present?
      # Check if there is a search parameter
      render_not_found_response("No movies #{params[:search]} with the given search criteria.")
    else
      # Render an empty array when there is no search parameter
      render_success_response('Movies fetched successfully', [], serializer: Movies::MovieSerializer)
    end
  end

  def options
    @movies = Movie.includes(:movie_genre).all

    render_success_response('Movies options', @movies, serializer: Movies::MovieOptionSerializer)
  end

  def show
    render_show_response('Movie fetched successfully', @movie, serializer: Movies::MovieSerializer)
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render_show_response('Movie created successfully', @movie, serializer: Movies::MovieSerializer,
                                                                 location: api_movie_url(@movie))
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      render_show_response('Movie updated successfully', @movie, serializer: Movies::MovieSerializer,
                                                                 location: api_movie_url(@movie))
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(
      :name, :description, :category, :released_at, :image_url, :status,
      { content_details: %i[duration country original_language languages licence] },
      :movie_genre_id, :video_link_id, :trailer_link_id, :movie_writter_id, movie_outcast_ids: []
    ) # { movie_outcast_ids: [] }
  end
end
