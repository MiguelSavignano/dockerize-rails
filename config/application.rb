require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require_relative '../lib/json_formatter'

module DockerizeRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.read_encrypted_secrets = false


    # config.logger = Ougai::Logger.new(STDOUT)
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Json.new
    config.colorize_logging = false
    config.log_formatter = JsonFormatter.new

    config.lograge.custom_options = lambda do |event|
      params = event.payload[:params].reject { |k| %w(controller action).include?(k) }
      {
        params: params,
      }
    end

    config.lograge.custom_payload do |controller|
      {
        host: controller.request.host,
        request_id: controller.request.uuid
      }
    end

    config.middleware.insert_after ActionDispatch::RequestId, RequestIdLogging::Middleware
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
