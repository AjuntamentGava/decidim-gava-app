# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.1.3"

DECIDIM_VERSION = "0.27.4"

if ENV["USE_LOCAL_DECIDIM"] == "true"
  gem "decidim", path: "~/dev/decidim"
else
  gem "decidim", DECIDIM_VERSION
end

gem "decidim-cdtb", git: "https://github.com/CodiTramuntana/decidim-module-cdtb", branch: "main"

# Temporal solution to prevent Psych::BadAlias
gem "psych", "<4"

gem "data_migrate"
gem "figaro", ">= 1.1.1"
gem "foundation-rails"
gem "httparty"
gem "progressbar"
gem "uglifier", ">= 1.3.0"
gem "daemons"
gem "delayed_job_active_record"
gem "whenever"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer.git", branch: "master"
gem "decidim-decidim_awesome", "~> 0.9.3"
gem "decidim-question_captcha", git: "https://github.com/OpenSourcePolitics/decidim-module-question_captcha", branch: "release/0.27-stable"
gem "acts_as_textcaptcha", "~> 4.6.0"

gem "puma"

gem "aws-sdk-s3", require: false

group :development, :test do
  gem "byebug", platform: :mri
end

group :development do
  gem "decidim-dev", DECIDIM_VERSION
  gem "web-console"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
  gem "faker"
  gem "capistrano-bundler"
  gem "pry-remote"
end

group :development, :staging do
  gem "letter_opener_web", "~> 1.4"
end

group :production do
  gem "fog-aws"
  gem "newrelic_rpm"
  gem "dalli"
  gem "rack-host-redirect"
end

group :test do
  gem "rspec-rails"
  gem "database_cleaner"
end
