json.extract! movie, :id, :name, :description, :category, :image_url, :content_details, :content_rating, :content_history,
              :views, :likes_counter, :comments_counter, :status, :movie_genre_id,
              :video_link_id, :trailer_link_id, :movie_writter_id, :movie_outcast_id, :created_at, :updated_at
json.url movie_url(movie, format: :json)
