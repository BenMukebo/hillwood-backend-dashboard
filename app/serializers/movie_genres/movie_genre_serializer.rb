module MovieGenres
  class MovieGenreSerializer < ApplicationSerializer
    attributes :value, :name

    def value
      object.id
    end
  end
end
