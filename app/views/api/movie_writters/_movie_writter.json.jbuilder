json.extract! movie_writter, :id, :first_name, :last_name, :avatar_url, :personal_details, :status, :created_at, :updated_at
json.url movie_writter_url(movie_writter, format: :json)
