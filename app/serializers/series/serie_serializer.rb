module Series
  class SerieSerializer < ApplicationSerializer
    attributes :id, :name, :description, :category, :image_url, :genre,
               :content_details, :status, :likes_counter, :comments_counter, :views

    belongs_to :movie_genre
    has_one :video_link
    has_one :movie_writter, serializer: MovieWritters::MovieWritterOptionSerializer
    has_many :serie_comments, serializer: SerieComments::SerieCommentSerializer

    def genre
      object.movie_genre.name
    end

    def likes_counter
      object.serie_likes.count
    end

    def comments_counter
      object.serie_comments.count
    end

    def video_link
      object.video_link.url
    end
  end
end
