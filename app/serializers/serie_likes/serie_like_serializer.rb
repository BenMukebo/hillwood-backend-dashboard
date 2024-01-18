module SerieLikes
  class SerieLikeSerializer < ApplicationSerializer
    attributes :id
    has_one :serie
    has_one :user
  end
end
