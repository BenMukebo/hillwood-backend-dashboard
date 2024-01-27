class Api::MovieLikesController < Api::ApiController
  before_action :set_movie_like, only: %i[show update destroy]

  def index
    # @movie_likes = MovieLike.all
    @movie_likes = MovieLike.includes(:user, :movie).all.to_a

    render_success_response('Movie likes fetched successfully', @movie_likes,
                            serializer: MovieLikes::MovieLikeSerializer)
  end

  def show
    render_show_response('Movie like fetched successfully', @movie_like,
                         serializer: MovieLikes::MovieLikeSerializer)
  end

  def create
    @movie_like = MovieLike.new(movie_like_params)

    if @movie_like.save
      # render :show, status: :created, location: @movie_like
      render_show_response('Movie like created successfully', @movie_like,
                           serializer: MovieLikes::MovieLikeSerializer,
                           location: api_movie_like_url(@movie_like))
    else
      render json: @movie_like.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie_like.update(movie_like_params)
      # render :show, status: :ok, location: @movie_like
      render_show_response('Movie like updated successfully', @movie_like,
                           serializer: MovieLikes::MovieLikeSerializer,
                           location: api_movie_like_url(@movie_like))
    else
      render json: @movie_like.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie_like.destroy
  end

  private

  def set_movie_like
    @movie_like = MovieLike.find(params[:id])
  end

  def movie_like_params
    params.require(:movie_like).permit(:movie_id, :user_id)
  end
end
