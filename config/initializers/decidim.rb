# frozen_string_literal: true

Decidim.configure do |config|
  config.application_name = Rails.application.secrets.decidim[:application_name]
  config.mailer_sender = Rails.application.secrets.decidim[:mailer_sender]
  config.maximum_attachment_size = 150.megabytes

  # Sets the list of available locales for the whole application.
  #
  # When an organization is created through the System area, system admins will
  # be able to choose the available languages for that organization. That list
  # of languages will be equal or a subset of the list in this file.
  # config.available_locales = Rails.application.secrets.decidim[:available_locales].presence || [:en]
  # Or block set it up manually and prevent ENV manipulation:
  config.available_locales = %w(ca es en)

  config.default_locale = Rails.application.secrets.decidim[:default_locale].presence || :ca

  # Custom HTML Header snippets
  #
  # The most common use is to integrate third-party services that require some
  # extra JavaScript or CSS. Also, you can use it to add extra meta tags to the
  # HTML. Note that this will only be rendered in public pages, not in the admin
  # section.
  #
  # Before enabling this you should ensure that any tracking that might be done
  # is in accordance with the rules and regulations that apply to your
  # environment and usage scenarios. This component also comes with the risk
  # that an organization's administrator injects malicious scripts to spy on or
  # take over user accounts.
  #
  config.enable_html_header_snippets = Rails.application.secrets.decidim[:enable_html_header_snippets].present?

  # Allow organizations admins to track newsletter links.
  config.track_newsletter_links = Rails.application.secrets.decidim[:track_newsletter_links].present? unless Rails.application.secrets.decidim[:track_newsletter_links] == "auto"

  if Rails.application.secrets.maps
    config.maps = {
      provider: :here,
      api_key: Rails.application.secrets.maps[:here_api_key],
      static: { url: "https://image.maps.hereapi.com/mia/v3/base/mc/overlay" }
    }
  end

  # Max requests in a time period to prevent DoS attacks. Only applied on production.
  config.throttling_max_requests = Rails.application.secrets.decidim[:throttling_max_requests].to_i

  # Time window in which the throttling is applied.
  config.throttling_period = Rails.application.secrets.decidim[:throttling_period].to_i.minutes

  config.follow_http_x_forwarded_host = Rails.application.secrets.decidim[:follow_http_x_forwarded_host].present?

  # Configure CSP
  config.content_security_policies_extra = {
    "connect-src" => %w(https://*.here.com https://*.hereapi.com https://*.s3.eu-west-3.amazonaws.com),
    "img-src" => %w(https://*.here.com https://*.hereapi.com https://*.s3.eu-west-3.amazonaws.com),
    "script-src" => %w(https://www.googletagmanager.com),
    "frame-src" => %w(https://*.s3.eu-west-3.amazonaws.com)
  }
end

Decidim::Verifications.register_workflow(:census_authorization_handler) do |auth|
  auth.form = "CensusAuthorizationHandler"
  auth.action_authorizer = "CensusAuthorizationHandler::ActionAuthorizer"

  auth.options do |options|
    options.attribute :maximum_age, type: :integer, required: false
    options.attribute :minimum_age, type: :integer, required: false
  end
end

if Decidim.module_installed? :verifications
  Decidim::Verifications.configure do |config|
    config.document_types = Rails.application.secrets.dig(:verifications, :document_types).presence || %w(identification_number passport)
  end
end
