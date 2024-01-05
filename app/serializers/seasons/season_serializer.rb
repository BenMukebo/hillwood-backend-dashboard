module Seasons
  class SeasonSerializer < ApplicationSerializer
    attributes :id, :title, :description, :image_url, :status, :episods_counter
    has_one :video_link
    has_one :serie
    belongs_to :serie
  end
end
