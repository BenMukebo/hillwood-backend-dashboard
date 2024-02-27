class Outcast < ApplicationRecord
  include Validatable

  has_many :outcast_associations, dependent: :destroy
  has_many :movies, through: :outcast_associations, source: :media_association, source_type: 'Movie'
  has_many :series, through: :outcast_associations, source: :media_association, source_type: 'Serie'

  def self.ransackable_attributes(_auth_object = nil)
    %w[avatar_url created_at date_of_birth first_name id last_name personal_details status updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[movies outcast_associations series]
  end
end
