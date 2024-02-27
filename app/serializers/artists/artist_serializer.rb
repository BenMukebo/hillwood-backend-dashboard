module Artists
  class ArtistSerializer < ApplicationSerializer
    attributes :id, :avatar_url, :first_name, :last_name, :date_of_birth, :personal_details, :status
  end
end
