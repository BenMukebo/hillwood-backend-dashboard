# app/models/concerns/media_filters.rb
module MediaFilters
  extend ActiveSupport::Concern

  included do
    scope :search_by_name, ->(name) { where('name ILIKE ?', "%#{name}%") if name.present? }
    scope :filter_by_artist_id, ->(artist_id) { where('artist_id = ?', artist_id) if artist_id.present? }
    scope :filter_by_movie_writer_id, ->(author_id) { where('movie_writter_id = ?', author_id) if author_id.present? }

    scope :filter_by_genre_id, ->(genre_id) { where('movie_genre_id = ?', genre_id) if genre_id.present? }
    # eg: comedie =/ comedies
    scope :filter_by_genre_name, lambda { |genre_name|
                                   joins(:movie_genre).where('movie_genres.name ILIKE :genre_name', genre_name:) if genre_name.present?
                                 }
    # eg 1: comedie == comedies
    # 1 scope :filter_by_genre_name, ->(genre_name) { joins(:movie_genre).where('movie_genres.name ILIKE :genre_name', genre_name: "%#{genre_name}%") }
  end
end

# 1. Using SQL placeholders (where("movie_genre_id = ?", genre_id))
# 2. Using named placeholders (where("movie_genre_id ILIKE :genre_id", movie_genre_id: genre_id))
# 3. Using string interpolation with ILIKE (where("movie_genre_id ILIKE ?", "%#{genre_id}%"))
# 4. Directly passing the value (where(movie_genre_id: genre_id))
# Options 1 and 2 are preferable in terms of security due to their protection against SQL injection.
# Options 3 and 4 are more vulnerable because they directly interpolate user input into the SQL query, which can open the door to SQL injection attacks.
