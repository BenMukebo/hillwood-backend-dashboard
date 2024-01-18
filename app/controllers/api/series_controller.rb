class Api::SeriesController < Api::ApiController
  before_action :set_series, only: %i[show update destroy]

  def index
    @search = search_params[:search]
    @series = @search.present? ? series_scope.search_by_name(@search) : series_scope

    # Check if series are present
    if @series.any?
      render_success_response('Series fetched successfully', @series, serializer: Series::SerieSerializer)
    else
      # Render an empty array when there is no search parameter
      render_success_response("No Series #{@search} found in the DB", [], serializer: Series::SerieSerializer)
    end
  end

  def options
    @search = search_params[:search]
    @series = @search.present? ? series_scope.search_by_name(@search) : series_scope

    if @series.any?
      render_success_response('Series options', @series, serializer: Series::SerieOptionSerializer)
    else
      render_success_response("No Series #{@search} found in the DB", @series, serializer: Series::SerieOptionSerializer)
    end
  end

  def show
    render_show_response('Series fetched successfully', @serie, serializer: Series::SerieSerializer)
  end

  def create
    @serie = Serie.new(series_params)

    if @serie.save
      render_show_response('Series created successfully', @serie, serializer: Series::SerieSerializer,
                                                                  location: api_series_url(@serie))
    else
      render json: @serie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @serie.update(series_params)
      render_show_response('Series updated successfully', @serie, serializer: Series::SerieSerializer,
                                                                  location: api_series_url(@serie))
    else
      render json: @serie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @serie.destroy
  end

  private

  def series_scope
    Serie.includes(:movie_genre).all.released
  end

  def search_params
    params.permit(:keyword, :page, :per_page, :search, :status)
  end

  def set_series
    @serie = Serie.find(params[:id])
  end

  def series_params
    params.require(:series).permit(
      :name, :description, :category, :image_url, :status,
      { content_details: %i[duration country original_language languages licence] },
      :movie_genre_id, :video_link_id, :trailer_link_id, :movie_writter_id, movie_outcast_ids: []
    )
  end
end
