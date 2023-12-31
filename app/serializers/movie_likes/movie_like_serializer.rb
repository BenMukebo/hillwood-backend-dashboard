module MovieLikes
  class MovieLikeSerializer < ApplicationSerializer
    attributes :id
    # has_one :movie
    # has_one :user
    belongs_to :movie
    belongs_to :user
  end
end
