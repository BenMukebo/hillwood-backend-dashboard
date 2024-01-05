class Videos::VideoSerializer < ApplicationSerializer
  attributes :id, :url, :status, :details, :created_at, :updated_at
end
