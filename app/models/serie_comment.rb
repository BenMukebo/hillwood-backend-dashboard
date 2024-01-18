class SerieComment < ApplicationRecord
  belongs_to :serie
  belongs_to :user

  # after_save :increase_commets_counter
  # after_destroy :decrease_commets_counter

  validates :text, presence: true, length: { minimum: 1, maximum: 1000 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id likes_counter serie_id text updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[serie user serie_likes]
  end

  private

  def increase_commets_counter
    serie&.increment!(:comments_counter)
  end

  def decrease_commets_counter
    serie&.decrement!(:comments_counter)
  end
end
