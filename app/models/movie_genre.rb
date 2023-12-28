class MovieGenre < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  # , uniqueness: { scope: :movie_id }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end

  # def self.ransackable_attributes(_auth_object = nil)
  #   %w[created_at genre_id id movie_id updated_at]
  # end

  # def self.ransackable_associations(_auth_object = nil)
  #   ['genre', 'movie']
  # end
end
