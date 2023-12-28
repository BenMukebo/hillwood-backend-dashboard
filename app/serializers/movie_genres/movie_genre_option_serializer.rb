module MovieGenres
  class MovieGenreOptionSerializer < ApplicationSerializer
    attributes :value, :name

    def value
      object.id
    end
  end
end
