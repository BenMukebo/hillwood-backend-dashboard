class Artists::ArtistOptionSerializer < ApplicationSerializer
  attributes :value, :name, :avatar_url

  def value
    object.id
  end

  def name
    "#{object.first_name} #{object.last_name}"
  end
end
