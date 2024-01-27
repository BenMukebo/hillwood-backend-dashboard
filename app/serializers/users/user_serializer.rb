module Users
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :username, :phone_number, :age_group, :terms_of_service,
               :verification_status, :profile, :location, :social_links, :role_id
    # belongs_to :role, serializer: Roles::RoleSerializer
  end
end
