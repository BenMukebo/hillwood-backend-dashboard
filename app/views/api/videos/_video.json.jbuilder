json.extract! video, :id, :url, :mime_type, :status, :created_at, :updated_at
json.url video_url(video, format: :json)
