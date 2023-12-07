class Users::UserProfileSerializer < ActiveModel::Serializer
  attributes :profile, :location, :social_links
  # , social_links: %i[facebook twitter instagram linkedin youtube]

  # has_one :profile, serializer: Users::ProfileSerializer
  # has_one :location, serializer: Users::LocationSerializer
  # has_one :social_links, serializer: Users::SocialLinkSerializer

  # def profile
  #   object.profile
  # end
  #
  # def location
  #   object.location
  # end
  #
  # def social_links
  #   object.social_links
  # end
end
