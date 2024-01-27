class Api::SerieCommentsController < Api::ApiController
  before_action :set_serie_comment, only: %i[show update destroy]

  def index
    @serie_comments = SerieComment.includes(:user).all.to_a

    render_success_response('Serie comments fetched successfully', @serie_comments,
                            serializer: SerieComments::SerieCommentSerializer)
  end

  def show
    render_show_response('Serie comment fetched successfully', @serie_comment,
                         serializer: SerieComments::SerieCommentSerializer)
  end

  def create
    @serie_comment = SerieComment.new(serie_comment_params)

    if @serie_comment.save
      render_show_response('Serie comment created successfully', @serie_comment,
                           serializer: SerieComments::SerieCommentSerializer,
                           location: api_serie_comment_url(@serie_comment))
    else
      render json: @serie_comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @serie_comment.update(serie_comment_params)
      render_show_response('Serie comment updated successfully', @serie_comment,
                           serializer: SerieComments::SerieCommentSerializer,
                           location: api_serie_comment_url(@serie_comment))
    else
      render json: @serie_comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @serie_comment.destroy
  end

  private

  def set_serie_comment
    @serie_comment = SerieComment.find(params[:id])
  end

  def serie_comment_params
    params.require(:serie_comment).permit(:text, :likes_counter, :serie_id, :user_id)
  end
end
