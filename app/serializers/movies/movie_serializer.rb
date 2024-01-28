module Movies
  class MovieSerializer < ApplicationSerializer
    attributes :id, :name, :description, :category, :image_url, :genre,
               :released_at, :content_details,
               # :content_rating, :content_history,
               :views, :likes_counter, :comments_counter, :status

    # has_one :movie_genre # You can use either has_one or belongs_to
    # belongs_to :genre # You can use any any (movie_genre or genre) as long as you have the serializer method
    has_one :video_link
    has_one :trailer_link
    has_one :movie_writter, serializer: MovieWritters::MovieWritterOptionSerializer
    # has_many :movie_outcasts
    # has_many :movie_comments, serializer: MovieComments::MovieCommentSerializer
    # has_many :movie_likes, serializer: MovieLikes::MovieLikeSerializer

    def genre
      object.movie_genre.name
    end

    def video_link
      #   object.video_link.url
      return unless object.video_link

      { id: object.video_link.id,
        url: object.video_link.url,
        status: object.video_link.status,
        details: object.video_link.details }
    end

    def trailer_link
      return unless object.trailer_link

      { id: object.trailer_link.id,
        url: object.trailer_link.url,
        status: object.trailer_link.status,
        details: object.trailer_link.details }
    end

    # def movie_writter
    #   "#{object.movie_writter.first_name} #{object.movie_writter.last_name}"
    # end
  end
end
