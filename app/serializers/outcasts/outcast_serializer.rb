module Outcasts
  class OutcastSerializer < ApplicationSerializer
    attributes :id, :avatar_url, :first_name, :last_name, :date_of_birth,
               :personal_details, :status

    has_and_belongs_to_many :movies, serializer: MovieOptionSerializer
    has_and_belongs_to_many :series, serializer: SeriesOptionSerializer
    # has_and_belongs_to_many :tv_shows, serializer: TvShowOptionSerializer
  end
end
