class Api::MovieWrittersController < Api::ApiController
  before_action :set_movie_writter, only: %i[show update destroy]

  def index
    @movie_writters = MovieWritter.includes(:movies).all.to_a

    # render json: @movie_writters, each_serializer: MovieWritters::MovieWritterSerializer, status: :ok
    render_success_response('Writters movie full details fetched successfully', @movie_writters,
                            serializer: MovieWritters::MovieWritterSerializer)
  end

  def options
    @movie_writters = MovieWritter.all

    render_success_response('Writters movie options', @movie_writters,
                            serializer: MovieWritters::MovieWritterOptionSerializer)
  end

  def show
    render_show_response('Writter fetched successfully', @movie_writter,
                         serializer: MovieWritters::MovieWritterSerializer)
  end

  def create
    @movie_writter = MovieWritter.new(movie_writter_params)

    if @movie_writter.save
      # render :show, status: :created, location: api_movie_writter_url(@movie_writter)
      render_show_response('Writter created successfully', @movie_writter,
                           serializer: MovieWritters::MovieWritterSerializer,
                           location: api_movie_writter_url(@movie_writter))
    else
      render json: @movie_writter.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie_writter.update(movie_writter_params)
      # render :show, status: :ok, location: @movie_writter
      render_show_response('Writter updated successfully', @movie_writter,
                           serializer: MovieWritters::MovieWritterSerializer,
                           location: api_movie_writter_url(@movie_writter))
    else
      render json: @movie_writter.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie_writter.destroy
  end

  private

  def set_movie_writter
    @movie_writter = MovieWritter.find(params[:id])
  end

  def movie_writter_params
    params.require(:movie_writter).permit(
      :avatar_url, :first_name, :last_name, :status, { personal_details:
      %i[address bio date_of_birth first_name last_name phone_number interests languages sex] }
    )
  end
end
