class Api::MoviesController < Api::ApiController
  before_action :set_movie, only: %i[show update destroy]

  def index
    @movies = if params[:search].present?
                Movie.includes(:movie_genre).where('name LIKE :search', search: "%#{params[:search]}%")
              else
                Movie.includes(:movie_genre).all.to_a
              end

    # Check if movies are present
    if @movies.any?
      render_success_response('Movies fetched successfully', @movies, serializer: Movies::MovieSerializer)
    elsif params[:search].present?
      # Check if there is a search parameter
      render_not_found_response("No movies #{params[:search]} with the given search criteria.")
    else
      # Render an empty array when there is no search parameter
      render_success_response('Movies fetched successfully', [], serializer: Movies::MovieSerializer)
    end
  end

  def options
    @movies = Movie.all

    render_success_response('Movies options', @movies, serializer: Movies::MovieOptionSerializer)
  end

  def show
    render_show_response('Movie fetched successfully', @movie, serializer: Movies::MovieSerializer)
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render_show_response('Movie created successfully', @movie, serializer: Movies::MovieSerializer,
                                                                 location: api_movie_url(@movie))
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      render_show_response('Movie updated successfully', @movie, serializer: Movies::MovieSerializer,
                                                                 location: api_movie_url(@movie))
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(
      :name, :description, :category, :image_url, :status,
      { content_details: %i[duration country default_language languages licence] },
      # :views_counter, :likes_counter, :comments_counter,
      :movie_genre_id, :video_link_id, :trailer_link_id, :movie_writter_id, movie_outcast_ids: []
    ) # { movie_outcast_ids: [] }
  end
end

# { content_history: %i[ ] }, movie_directors
# t.jsonb :details, null: false, default: { duration: nil, views_counter: nil, likes_counter: nil, comments_counter: nil, published_at: nil, updated_at: nil, category: nil, tags: nil, thumbnail: nil, author: nil, author_url: nil, author_avatar: nil, author_subscribers: nil, author_videos: nil, author_views: nil, author_comments: nil, author_likes: nil, author_dislikes: nil, author_joined: nil, author_verified: nil, author_verified_reason: nil, author_country: nil, author_country_code: nil, author_channel_id: nil, author_channel_url: nil, author_channel_type: nil, author_channel_name: nil, author_channel_description: nil, author_channel_subscribers: nil, author_channel_videos: nil, author_channel_views: nil, author_channel_comments: nil, author_channel_likes: nil, author_channel_dislikes: nil, author_channel_joined: nil, author_channel_verified: nil, author_channel_verified_reason: nil, author_channel_country: nil, author_channel_country_code: nil }
# t.jsonb :content_statistics, null: false, default: { views_counter: nil, likes_counter: nil, dislikes_counter: nil, comments_counter: nil, favorites_counter: nil, shares_counter: nil, estimated_revenue: nil, estimated_ad_revenue: nil, estimated_partner_ad_revenue: nil, estimated_partner_red_revenue: nil, estimated_partner_transaction_revenue: nil, estimated_partner_subscription_revenue: nil, estimated_partner_super_chat_revenue: nil, estimated_partner_super_sticker_revenue: nil, estimated_partner_memberships_revenue: nil, estimated_partner_other_revenue: nil, estimated_partner_total_revenue: nil, estimated_partner_ad_revenue_share: nil, estimated_partner_red_revenue_share: nil, estimated_partner_transaction_revenue_share: nil, estimated_partner_subscription_revenue_share: nil, estimated_partner_super_chat_revenue_share: nil, estimated_partner_super_sticker_revenue_share: nil, estimated_partner_memberships_revenue_share: nil, estimated_partner_other_revenue_share: nil, estimated_partner_total_revenue_share: nil }
