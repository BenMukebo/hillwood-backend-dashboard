json.extract! movie_genre, :id, :name, :created_at, :updated_at
json.url movie_genre_url(movie_genre, format: :json)
