class MovieLike < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  after_save :increase_likes_counter
  after_destroy :decrease_likes_counter

  validates :movie_id, uniqueness: { scope: :user_id }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id movie_id updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[movie user]
  end

  # def self.search_by_movie_id(movie_id)
  #   where(movie_id: movie_id)
  # end

  # def self.search_by_user_id(user_id)
  #   where(user_id: user_id)
  # end

  # def self.search_by_movie_id_and_user_id(movie_id, user_id)
  #   where(movie_id: movie_id).where(user_id: user_id)
  # end

  # def self.search_by_movie_id_or_user_id(movie_id, user_id)
  #   where(movie_id: movie_id).or(where(user_id: user_id))
  # end

  private

  def increase_likes_counter
    movie&.increment!(:likes_counter)
  end

  def decrease_likes_counter
    movie&.decrement!(:likes_counter)
  end
end
