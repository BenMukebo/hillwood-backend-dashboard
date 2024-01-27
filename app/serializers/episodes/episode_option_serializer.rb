class Episodes::EpisodeOptionSerializer < ApplicationSerializer
  attributes :value, :name, :image_url

  def value
    object.id
  end
end
