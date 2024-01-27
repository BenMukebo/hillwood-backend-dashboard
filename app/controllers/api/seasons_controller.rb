class Api::SeasonsController < Api::ApiController
  before_action :set_season, only: %i[show update destroy]

  def index
    @seasons = Season.all

    render_success_response('Seasons fetched successfully', @seasons,
                            serializer: Seasons::SeasonSerializer)
  end

  def show
    render_show_response('Season fetched successfully', @season,
                         serializer: Seasons::SeasonSerializer)
  end

  def create
    @season = Season.new(season_params)

    if @season.save
      render_show_response('Season created successfully', @season,
                           serializer: Seasons::SeasonSerializer,
                           location: api_season_url(@season))
    else
      render json: @season.errors, status: :unprocessable_entity
    end
  end

  def update
    if @season.update(season_params)
      render_show_response('Season updated successfully', @season,
                           serializer: Seasons::SeasonSerializer,
                           location: api_season_url(@season))
    else
      render json: @season.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @season.destroy
  end

  private

  def set_season
    @season = Season.find(params[:id])
  end

  def season_params
    params.require(:season).permit(:title, :description, :image_url, :released_at, :status,
                                   :video_link_id, :episods_counter, :serie_id)
  end
end
