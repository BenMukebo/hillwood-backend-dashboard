module Episodes
  class EpisodeSerializer < ApplicationSerializer
    attributes :id, :name, :description, :image_url, :released_at, :duration, :status

    has_one :video_link
    has_one :trailer_link
    has_one :season
    has_one :serie
  end
end
