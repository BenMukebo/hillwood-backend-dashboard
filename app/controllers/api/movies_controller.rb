class Api::MoviesController < Api::ApiController
  before_action :set_movie, only: %i[show update destroy]

  def index
    @search = search_params[:search]
    # @movies = @search.present? ? movie_scope.where('name LIKE :search', search: "%#{@search}%") : movie_scope
    @movies = @search.present? ? movie_scope.search_by_name(@search) : movie_scope

    # Check if movies are present
    if @movies.any?
      render_success_response('Movies fetched successfully', @movies, serializer: Movies::MovieSerializer)
      # elsif params[:search].present?
      # render_not_found_response("No movies #{params[:search]} with the given search criteria.")
    else
      render_success_response("No movies #{@search} found in the DB", @movies, serializer: Movies::MovieSerializer)
    end
  end

  def options
    @search = search_params[:search]
    @movies = @search.present? ? movie_scope.search_by_name(@search) : movie_scope

    if @movies.any?
      render_success_response('Movies options', @movies, serializer: Movies::MovieOptionSerializer)
    else
      render_success_response("No movies #{@search} found in the DB", @movies, serializer: Movies::MovieOptionSerializer)
    end
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

  def movie_scope
    # Movie.includes(:movie_genre).all.where(status: 1).order('id DESC')
    Movie.includes(:movie_genre).all.released
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  # def set_movie_by_name
  #   @movie = Movie.find_by(name: params[:name])
  # end

  def request_method
    request.method.downcase
  end

  def search_params
    params.permit(:keyword, :page, :per_page, :search, :status)
  end

  def movie_params
    params.require(:movie).permit(
      :name, :description, :category, :released_at, :image_url, :status,
      { content_details: %i[duration country original_language languages licence] },
      :movie_genre_id, :video_link_id, :trailer_link_id, :movie_writter_id, movie_outcast_ids: []
    ) # { movie_outcast_ids: [] }
  end
end
