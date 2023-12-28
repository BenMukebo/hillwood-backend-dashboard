module MovieWritters
  class MovieWritterOptionSerializer < ApplicationSerializer
    attributes :value, :name

    def value
      object.id
    end
  end
end
