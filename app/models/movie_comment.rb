class MovieComment < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :movie_likes, dependent: :destroy

  after_save :increase_commets_counter
  after_destroy :decrease_commets_counter

  validates :text, presence: true, length: { minimum: 1, maximum: 1000 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id likes_counter text updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[movie user movie_likes]
  end

  private

  def increase_commets_counter
    movie&.increment!(:comments_counter)
  end

  def decrease_commets_counter
    movie&.decrement!(:comments_counter)
  end

  # def self.ransackable_attributes(_auth_object = nil)
  #   %w[created_at id likes_counter text updated_at]
  # end

  # def self.ransackable_associations(_auth_object = nil)
  #   ['movie', 'user']
  # end

  # def self.search_by_text(text)
  #   where('text ILIKE ?', "%#{text}%")
  # end

  # def self.search_by_likes_counter(likes_counter)
  #   where(likes_counter: likes_counter)
  # end

  # def self.search_by_text_and_likes_counter(text, likes_counter)
  #   where('text ILIKE ?', "%#{text}%").where(likes_counter: likes_counter)
  # end

  # def self.search_by_text_or_likes_counter(text, likes_counter)
  #   where('text ILIKE ? OR likes_counter = ?', "%#{text}%", likes_counter)
  # end
end
