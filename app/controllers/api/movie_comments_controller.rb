class Api::MovieCommentsController < Api::ApiController
  before_action :set_movie_comment, only: %i[show update destroy]

  def index
    # @movie_comments = MovieComment.all
    @movie_comments = MovieComment.includes(:user).all.to_a

    render_success_response('Movie comments fetched successfully', @movie_comments,
                            serializer: MovieComments::MovieCommentSerializer)
  end

  def show
    render_show_response('Movie comment fetched successfully', @movie_comment,
                         serializer: MovieComments::MovieCommentSerializer)
  end

  def create
    @movie_comment = MovieComment.new(movie_comment_params)

    if @movie_comment.save
      # render :show, status: :created, location: @movie_comment
      render_show_response('Movie comment created successfully', @movie_comment,
                           serializer: MovieComments::MovieCommentSerializer,
                           location: api_movie_comment_url(@movie_comment))
    else
      render json: @movie_comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie_comment.update(movie_comment_params)
      # render :show, status: :ok, location: @movie_comment
      render_show_response('Movie comment updated successfully', @movie_comment,
                           serializer: MovieComments::MovieCommentSerializer,
                           location: api_movie_comment_url(@movie_comment))
    else
      render json: @movie_comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie_comment.destroy
  end

  private

  def set_movie_comment
    @movie_comment = MovieComment.find(params[:id])
  end

  def movie_comment_params
    params.require(:movie_comment).permit(:text, :likes_counter, :movie_id, :user_id)
  end
end
