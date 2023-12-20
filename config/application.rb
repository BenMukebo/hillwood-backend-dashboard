# TODO: Adapt this application and make it an API one
# add the following line at the top of the Application class definition:
# config.api_only = true

require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

require_relative "boot"
require "rails/all"
# require 'letter_opener' if Rails.env.development? # To fix Invalid delivery method :letter_opener error

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HillwoodBackendDashboard
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # config.serve_static_files = true # Extend for Heroku and production
    config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :forbidden

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client', 'Authorization'],
          methods: [:get, :post, :options, :delete, :put]
      end
    end

    # config.middleware.insert_before ActionDispatch::Static, Rack::Cors do
    #   allow do
    #     origins '*'
    #     resource '*',
    #       headers: :any,
    #       methods: [:get, :post, :put, :patch, :delete, :options, :head]
    #   end
    # end

    config.action_mailer.default_url_options = { host: 'localhost', port: 8000 }

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    # config.autoload_lib(ignore: %w(assets tasks))  TODO: Not sure about this line

    # Emcomment these three line to fix ActionDispatch::Request::Session::DisabledSessionError when enable config.api_only = true
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options

    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Session::CookieStore

    # Configuration for the application, engines, and railties goes here.
    #
    # ActiveModelSerializers.config.adapter = :json_api # Default: `:attributes`
  
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.api_only = true
  end
end
