class ApplicationSerializer < ActiveModel::Serializer
  Rails.application.routes.default_url_options = {
    host: 'hillwood.com'
  }
end
