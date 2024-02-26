class Api::SeriesController < Api::ApiController
  # skip_before_action :authenticate_api_user!, only: %i[index show options]
  before_action :set_series, only: %i[show update destroy]

  def index
    @series = series_scope
    apply_series_filters

    render_success_response('Series fetched successfully', @series, serializer: Series::SerieSerializer)
  end

  def options
    @search = query_params[:search]
    @series = @search.present? ? Serie.all.search_by_name(@search) : Serie.all

    # Check if series are present
    if @series.present?
      render_success_response('Series options', @series, serializer: Series::SerieOptionSerializer)
    else
      # Render an empty array when there is no search parameter
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

  def apply_series_filters
    @series = @series.search_by_name(query_params[:search])
    @series = @series.filter_by_genre_name(query_params[:genre]) if query_params[:genre].present?
    @series = @series.filter_by_movie_writer_id(query_params[:author_id]) if query_params[:author_id].present?
    # @series = @series.filter_by_genre_id(params[:genre_id]) if params[:genre_id].present?
  end

  def series_scope
    Serie.includes(%i[movie_genre movie_writter serie_comments serie_likes outcasts outcast_associations video_link]).all.released
  end

  def query_params
    params.permit(:page, :per_page, :search, :sort_by, :genre, :status, :author_id)
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
