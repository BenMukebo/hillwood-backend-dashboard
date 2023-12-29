class Movies::MovieSerializer < ApplicationSerializer
  attributes :id, :name, :description, :category, :image_url,
             :content_details,
             # :content_rating, :content_history,
             :views_counter, :likes_counter, :comments_counter, :status

  # has_one :movie_genre
  belongs_to :movie_genre
  # has_one :video_link
  # has_one :trailer_link
  # has_one :movie_writter
  # has_many :movie_outcast
end
