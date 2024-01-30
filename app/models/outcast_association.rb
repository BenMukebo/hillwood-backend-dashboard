class OutcastAssociation < ApplicationRecord
  belongs_to :outcast, dependent: :destroy
  belongs_to :media_association, polymorphic: true, dependent: :destroy

  enum role: { actor: 0, director: 1, writter: 2 }, _default: 'actor', _prefix: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id media_association_id media_association_type outcast_id role created_at updated_at]
  end
end
