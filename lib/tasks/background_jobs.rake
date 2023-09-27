# frozen_string_literal: true

ENQUEUED_JOBS_THRESHOLD = 5

namespace :background_jobs do
  task check_pending: [:environment] do
    stats = Sidekiq::Stats.new

    if stats.enqueued > ENQUEUED_JOBS_THRESHOLD
      Rollbar.error("There are #{stats.enqueued} enqueued jobs. Please review if all queues from decidim are present in config/sidekiq.yml")
    end
  end
end
