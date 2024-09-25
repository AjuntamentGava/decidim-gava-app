# frozen_string_literal: true

require_relative "boot"
require "decidim/rails"
require "action_cable"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DecidimBarcelona
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = "Europe/Madrid"

    # Locales
    config.i18n.available_locales = %w(ca es en)
    config.i18n.default_locale = :en
    config.i18n.enforce_available_locales = false
    config.i18n.fallbacks = { ca: [:en], es: [:en] }

    required_files = [
      Rails.root.join("lib")
    ]
    config.autoload_paths += required_files
    config.eager_load_paths += required_files
  end
end
