class Api::ArtistsController < Api::ApiController
  # skip_before_action :authenticate_api_user!, only: %i[index show options]
  before_action :set_artist, only: %i[show update destroy]

  def index
    @artists = artist_scope

    render_success_response('Artists fetched successfully', @artists, serializer: Artists::ArtistSerializer)
  end

  def options
    @search = search_params[:search]
    @artists = @search.present? ? artist_scope.search_by_full_name(@search) : artist_scope

    if @artists.any?
      render_success_response('Artists options', @artists, serializer: Artists::ArtistOptionSerializer)
    else
      render_success_response("No artists #{@search} found in the DB", @artists)
    end
  end

  def show
    render_show_response('Artist fetched successfully', @artist, serializer: Artists::ArtistSerializer)
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      render_show_response('Artist created successfully', @artist, serializer: Artists::ArtistSerializer,
                                                                   location: api_artist_url(@artist))
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  def update
    if @artist.update(artist_params)
      render_show_response('Artist updated successfully', @artist, serializer: Artists::ArtistSerializer,
                                                                   location: api_artist_url(@artist))
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @artist.destroy
  end

  private

  def artist_scope
    Artist.all # .includes(:musics, :albums, :genres, :awards)
  end

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def search_params
    params.permit(:keyword, :page, :per_page, :search, :status)
  end

  def artist_params
    params.require(:artist).permit(:avatar_url, :first_name, :last_name, :date_of_birth, :personal_details, :status)
  end
end
