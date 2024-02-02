class Artist < ApplicationRecord
  include Validatable

  def self.ransackable_attributes(_auth_object = nil)
    %w[avatar_url created_at date_of_birth first_name id last_name personal_details status updated_at]
  end
end
