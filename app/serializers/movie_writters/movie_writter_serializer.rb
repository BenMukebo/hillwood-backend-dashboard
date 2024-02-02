class MovieWritters::MovieWritterSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :avatar_url, :date_of_birth,
             :personal_details, :status
end
