module MovieOutcasts
  class MovieOutcastSerializer < ApplicationSerializer
    attributes :id, :first_name, :last_name, :avatar_url, :personal_details, :status
  end
end
