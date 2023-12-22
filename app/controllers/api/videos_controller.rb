class Api::VideosController < Api::ApiController
  before_action :set_video, only: %i[show update destroy]

  def index
    @videos = Video.all
    render json: @videos, each_serializer: Videos::VideoSerializer, status: :ok
  end

  def show
    render json: @video, serializer: Videos::VideoSerializer, status: :ok
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      # render :show, status: :created, location: api_video_url(@video)
      render json: @video, serializer: Videos::VideoSerializer, status: :created
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /videos/1.json
  def update
    if @video.update(video_params)
      # render :show, status: :ok, location: @video
      render json: @video, serializer: Videos::VideoSerializer, status: :ok
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # DELETE /videos/1.json
  def destroy
    @video.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_video
    @video = Video.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def video_params
    params.require(:video).permit(:url, :mime_type, :status)
  end
end
