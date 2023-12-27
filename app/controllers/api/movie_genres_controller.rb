class Api::MovieGenresController < Api::ApiController
  before_action :set_movie_genre, only: %i[show update destroy]

  OptionsModule = Options

  def index
    @movie_genres = MovieGenre.all

    # render json: @movie_genres, each_serializer: MovieGenres::MovieGenreSerializer, status: :ok
    render_success_response('Genres movie fetched successfully', @movie_genres, serializer: MovieGenres::MovieGenreSerializer)
  end

  def show; end

  def create
    @movie_genre = MovieGenre.new(movie_genre_params)

    if @movie_genre.save
      render :show, status: :created, location: @movie_genre
    else
      render json: @movie_genre.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie_genre.update(movie_genre_params)
      render :show, status: :ok, location: @movie_genre
    else
      render json: @movie_genre.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie_genre.destroy
  end

  private

  def set_movie_genre
    @movie_genre = MovieGenre.find(params[:id])
  end

  def movie_genre_params
    params.require(:movie_genre).permit(:name)
  end
end
