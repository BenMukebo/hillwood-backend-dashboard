class Api::EpisodesController < Api::ApiController
  before_action :set_episode, only: %i[show update destroy]

  def index
    @episodes = if params[:search].present?
                  Episode.includes(:season).where('name LIKE :search', search: "%#{params[:search]}%")
                else
                  Episode.includes(:season).all.to_a
                end

    # Check if episodes are present
    if @episodes.any?
      render_success_response('Episodes fetched successfully', @episodes, serializer: Episodes::EpisodeSerializer)
    elsif params[:search].present?
      # Check if there is a search parameter
      render_not_found_response("No episodes #{params[:search]} with the given search criteria.")
    else
      # Render an empty array when there is no search parameter
      render_success_response('Episodes fetched successfully', [], serializer: Episodes::EpisodeSerializer)
    end
  end

  def options
    @episodes = Episode.includes(:season).all

    render_success_response('Episodes options', @episodes, serializer: Episodes::EpisodeOptionSerializer)
  end

  def show
    render_show_response('Episode fetched successfully', @episode, serializer: Episodes::EpisodeSerializer)
  end

  def create
    @episode = Episode.new(episode_params)

    if @episode.save
      render_show_response('Episode created successfully', @episode, serializer: Episodes::EpisodeSerializer,
                                                                     location: api_episode_url(@episode))
    else
      render json: @episode.errors, status: :unprocessable_entity
    end
  end

  def update
    if @episode.update(episode_params)
      # render :show, status: :ok, location: @episode
      render_show_response('Episode updated successfully', @episode, serializer: Episodes::EpisodeSerializer,
                                                                     location: api_episode_url(@episode))
    else
      render json: @episode.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @episode.destroy
  end

  private

  def set_episode
    @episode = Episode.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:name, :description, :image_url, :released_at, :duration, :status,
                                    :video_link_id, :trailer_link_id, :season_id, :serie_id)
  end
end
