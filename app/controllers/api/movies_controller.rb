class Api::MoviesController < Api::ApiController
  # skip_before_action :authenticate_api_user!, only: %i[index show options]
  before_action :set_movie, only: %i[show update destroy]

  def index
    @movies = movie_scope
    apply_movies_filters

    render_success_response('Movies fetched successfully', @movies, serializer: Movies::MovieSerializer)
  end

  def options
    @search = query_params[:search]
    @movies = @search.present? ? Movie.all.search_by_name(@search) : Movie.all

    if @movies.present?
      render_success_response('Movies options', @movies, serializer: Movies::MovieOptionSerializer)
      # elsif params[:search].present?
      # render_not_found_response("No movies #{params[:search]} with the given search criteria.")
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

  def apply_movies_filters
    @movies = @movies.search_by_name(query_params[:search])
      .filter_by_genre_name(query_params[:genre])
      .filter_by_movie_writer_id(query_params[:author_id])
    # .filter_by_genre_id(params[:genre_id])
  end

  def movie_scope
    # Movie.includes(:movie_genre).all.where(status: 1).order('id DESC')
    Movie.includes(%i[movie_genre movie_writter outcasts video_link trailer_link]).all.released
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

  def query_params
    params.permit(:page, :per_page, :search, :sort_by, :genre, :status, :author_id)
  end

  def movie_params
    params.require(:movie).permit(
      :name, :description, :category, :released_at, :image_url, :status,
      { content_details: %i[duration country original_language languages licence] },
      :movie_genre_id, :video_link_id, :trailer_link_id, :movie_writter_id, movie_outcast_ids: []
    ) # { movie_outcast_ids: [] }
  end
end
