class Api::SeriesController < Api::ApiController
  before_action :set_series, only: %i[show update destroy]

  def index
    @series = Serie.all
  end

  def options
    @series = Series.includes(:movie_genre).all

    render_success_response('Series options', @series, serializer: Series::SeriesOptionSerializer)
  end

  def show
    render_show_response('Series fetched successfully', @series, serializer: Series::SeriesSerializer)
  end

  def create
    @series = Serie.new(series_params)

    if @series.save
      render_show_response('Series created successfully', @series, serializer: Series::SeriesSerializer,
                                                                   location: api_series_url(@series))
    else
      render json: @series.errors, status: :unprocessable_entity
    end
  end

  def update
    if @series.update(series_params)
      render_show_response('Series updated successfully', @series, serializer: Series::SeriesSerializer,
                                                                   location: api_series_url(@series))
    else
      render json: @series.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @series.destroy
  end

  private

  def set_series
    @series = Serie.find(params[:id])
  end

  def series_params
    params.require(:series).permit(
      :name, :description, :category, :image_url, :status,
      { content_details: %i[duration country original_language languages licence] },
      :movie_genre_id, :video_link_id, :trailer_link_id, :movie_writter_id, movie_outcast_ids: []
    )
  end
end
