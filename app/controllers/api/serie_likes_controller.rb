class SerieLikesController < ApplicationController
  before_action :set_serie_like, only: %i[show update destroy]

  def index
    @serie_likes = SerieLike.includes(:user, :serie).all.to_a

    render_success_response('Serie likes fetched successfully', @serie_likes,
                            serializer: SerieLikes::SerieLikeSerializer)
  end

  def show
    render_show_response('Serie like fetched successfully', @serie_like,
                         serializer: SerieLikes::SerieLikeSerializer)
  end

  def create
    @serie_like = SerieLike.new(serie_like_params)

    if @serie_like.save
      # render :show, status: :created, location: @serie_like
      render_show_response('Serie like created successfully', @serie_like,
                           serializer: SerieLikes::SerieLikeSerializer,
                           location: api_serie_like_url(@serie_like))
    else
      render json: @serie_like.errors, status: :unprocessable_entity
    end
  end

  def update
    if @serie_like.update(serie_like_params)
      # render :show, status: :ok, location: @serie_like
      render_show_response('Serie like updated successfully', @serie_like,
                           serializer: SerieLikes::SerieLikeSerializer,
                           location: api_serie_like_url(@serie_like))
    else
      render json: @serie_like.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @serie_like.destroy
  end

  private

  def set_serie_like
    @serie_like = SerieLike.find(params[:id])
  end

  def serie_like_params
    params.require(:serie_like).permit(:serie_id, :user_id)
  end
end
