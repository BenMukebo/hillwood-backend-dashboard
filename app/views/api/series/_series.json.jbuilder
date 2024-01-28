json.extract! series, :id, :name, :description, :category, :image_url, :content_details, :status, :movie_genre_id, :video_link_id,
              :trailer_link_id, :movie_writter_id, :movie_outcast_id, :created_at, :updated_at
json.url series_url(series, format: :json)
