require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SoundsFetch
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins Settings.cors.host

        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :delete]
      end
    end

    config.paths.add 'lib', eager_load: true
  end
end
