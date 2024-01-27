json.extract! movie_like, :id, :movie_id, :user_id, :created_at, :updated_at
json.url movie_like_url(movie_like, format: :json)
