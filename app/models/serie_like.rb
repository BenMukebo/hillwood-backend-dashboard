class SerieLike < ApplicationRecord
  belongs_to :serie
  belongs_to :user

  after_save :increase_likes_counter
  after_destroy :decrease_likes_counter

  validates :serie_id, uniqueness: { scope: :user_id }

  private

  def increase_likes_counter
    serie&.increment!(:likes_counter)
  end

  def decrease_likes_counter
    serie&.decrement!(:likes_counter)
  end
end
