require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# youve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# config/application.rb
module PostCrossing
  # PostCrossing Application
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.exceptions_app = routes
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # Timezone needs to be UTC otherwise the stats won't show correctly
    config.time_zone = 'UTC'
    config.eager_load_paths << Rails.root.join('lib')
  end
end
