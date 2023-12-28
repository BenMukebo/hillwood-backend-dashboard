module MovieOutcasts
  class MovieOutcastOptionSerializer < ApplicationSerializer
    attributes :value, :name

    def value
      object.id
    end
  end
end
