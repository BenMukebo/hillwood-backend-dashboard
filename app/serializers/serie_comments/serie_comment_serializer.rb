module SerieComments
  class SerieCommentSerializer < ApplicationSerializer
    attributes :id, :text, :likes_counter
    has_one :serie
    has_one :user
  end
end
