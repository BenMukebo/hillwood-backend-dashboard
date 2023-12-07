module Users
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :phone_number, :age_group, :verification_status,
               :profile, :location, :social_links, :role_id
    # belongs_to :role, serializer: Roles::RoleSerializer
  end
end
