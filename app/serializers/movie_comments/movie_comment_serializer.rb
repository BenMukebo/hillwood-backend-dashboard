module MovieComments
  class MovieCommentSerializer < ApplicationSerializer
    attributes :id, :text, :likes_counter
    # has_one :movie
    # has_one :user
    belongs_to :movie
    belongs_to :user
  end
end
