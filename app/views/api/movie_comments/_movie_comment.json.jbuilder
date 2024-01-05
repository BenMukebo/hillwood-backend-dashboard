json.extract! movie_comment, :id, :text, :likes_counter, :movie_id, :user_id, :created_at, :updated_at
json.url movie_comment_url(movie_comment, format: :json)
