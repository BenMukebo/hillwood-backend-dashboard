class Videos::VideoSerializer < ApplicationSerializer
  attributes :id, :url, :mime_type, :status
end
