class Artist < ApplicationRecord
  include Validatable

  def self.ransackable_attributes(_auth_object = nil)
    %w[avatar_url created_at date_of_birth first_name id last_name personal_details status updated_at]
  end

  scope :search_by_full_name, ->(search) { where('first_name ILIKE ? OR last_name ILIKE ?', "%#{search}%", "%#{search}%") }
end
