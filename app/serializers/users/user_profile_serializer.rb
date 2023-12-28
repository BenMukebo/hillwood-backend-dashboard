module Users
  class UserProfileSerializer < Users::UserSerializer
    attributes :allow_password_change, :welcome_email_send, :created_at, :updated_at

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
end
