class Roles::RoleSerializer < ApplicationSerializer
  attributes :id, :name

  # has_many :users, serializer: Users::UserSerializer # if u uncomment this line, add this line
  # @roles = Role.includes(:users).all into your controller
end
