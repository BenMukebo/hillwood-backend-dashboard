class Api::VideosController < Api::ApiController
  before_action :set_video, only: %i[show update destroy]

  def index
    @videos = Video.all
    # render json: @videos, each_serializer: Videos::VideoSerializer, status: :ok
    render_success_response('Videos fetched successfully', @videos,
                            serializer: Videos::VideoSerializer)
  end

  def show
    # render json: @video, serializer: Videos::VideoSerializer, status: :ok
    render_show_response('Video fetched successfully', @video,
                         serializer: Videos::VideoSerializer)
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      # render :show, status: :created, location: api_video_url(@video)
      # render json: @video, serializer: Videos::VideoSerializer, status: :created
      render_show_response('Video created successfully', @video,
                           serializer: Videos::VideoSerializer,
                           location: api_video_url(@video))
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def update
    if @video.update(video_params)
      # render :show, status: :ok, location: @video
      # render json: @video, serializer: Videos::VideoSerializer, status: :ok
      render_show_response('Video updated successfully', @video,
                           serializer: Videos::VideoSerializer,
                           location: api_video_url(@video))
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @video.destroy
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(
      :url, :status,
      { details: %i[duration definition dimention size caption language mime_type] }
    )
  end
end
