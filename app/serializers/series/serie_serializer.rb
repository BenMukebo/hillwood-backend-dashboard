module Series
  class SerieSerializer < ApplicationSerializer
    attributes :id, :name, :description, :category, :image_url,
               :content_details, :status

    has_one :movie_genre
    belongs_to :movie_genre
    has_one :video_link
    has_one :movie_writter, serializer: MovieWritters::MovieWritterSerializer
    # has_one :movie_outcast
  end
end
