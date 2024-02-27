class MovieWritter < ApplicationRecord
  include Validatable

  has_many :movies, dependent: :destroy
  has_many :series, dependent: :destroy, class_name: 'Serie' # , foreign_key: 'movie_writter_id'

  def self.ransackable_attributes(_auth_object = nil)
    %w[avatar_url created_at date_of_birth first_name id last_name personal_details status updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[movies series]
  end
end
