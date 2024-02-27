json.extract! artist, :id, :avatar_url, :first_name, :last_name, :date_of_birth, :personal_details, :status, :created_at, :updated_at
json.url api_artists_url(artist, format: :json)
