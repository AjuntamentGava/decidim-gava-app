# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { git: "https://github.com/CodiTramuntana/decidim", branch: "release/0.29-stable" }.freeze

gem "decidim", DECIDIM_VERSION

gem "acts_as_textcaptcha", "~> 4.6.0"
gem "daemons"
gem "data_migrate"
gem "decidim-cdtb", "~> 0.6.0"
gem "decidim-decidim_awesome", git: "https://github.com/decidim-ice/decidim-module-decidim_awesome.git", branch: "release/0.29-stable"
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer.git", branch: "main"
gem "deface"
# Set versions because NameError: uninitialized constant ActiveJob::QueueAdapters::AbstractAdapter
gem "delayed_job", "~> 4.1.0"
gem "delayed_job_active_record", "~> 4.1.0"
gem "figjam"
gem "foundation-rails"
gem "httparty"
gem "progressbar"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "whenever"

gem "puma"

group :development, :test do
  gem "byebug", platform: :mri
end

group :development do
  gem "capistrano-bundler"
  gem "decidim-dev", DECIDIM_VERSION
  gem "faker"
  gem "listen"
  gem "pry-remote"
  gem "web-console"
end

group :development, :staging do
  gem "letter_opener_web", "~> 1.4"
end

group :production do
  gem "aws-sdk-s3", require: false
  gem "dalli"
  gem "fog-aws"
  gem "rack-host-redirect"
end

group :production, :staging do
  gem "puma_worker_killer"
end

group :test do
  gem "database_cleaner"
end
