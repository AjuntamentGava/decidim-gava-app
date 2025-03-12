# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = "0.28.5"

if ENV.fetch("USE_LOCAL_DECIDIM", nil) == "true"
  gem "decidim", path: "~/dev/decidim"
else
  gem "decidim", DECIDIM_VERSION
end



# gem "acts_as_textcaptcha", "~> 4.6.0"
gem "daemons"
gem "data_migrate"
# gem "decidim-decidim_awesome", "~> 0.9.3"
# gem "decidim-question_captcha", git: "https://github.com/OpenSourcePolitics/decidim-module-question_captcha", branch: "release/0.27-stable"
# gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer.git", branch: "master"
gem "decidim-cdtb"
gem "deface"
gem "delayed_job_active_record"
gem "figjam"
gem "foundation-rails"
gem "httparty"
gem "progressbar"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "whenever"

gem "puma"
gem "puma_worker_killer"

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

group :test do
  gem "database_cleaner"
  gem "rspec-rails"
end
