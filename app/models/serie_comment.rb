class SerieComment < ApplicationRecord
  belongs_to :serie
  belongs_to :user

  after_save :increase_commets_counter
  after_destroy :decrease_commets_counter

  validates :text, presence: true, length: { minimum: 1, maximum: 1000 }

  private

  def increase_commets_counter
    serie&.increment!(:comments_counter)
  end

  def decrease_commets_counter
    serie&.decrement!(:comments_counter)
  end
end
