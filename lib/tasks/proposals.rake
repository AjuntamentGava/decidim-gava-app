# frozen_string_literal: true

namespace :proposals do
  desc "Generate CSV report with supports per proposal (ENV: COMPONENT_ID, DATES comma-separated)"
  task supports: :environment do
    decidim_component_id = ENV.fetch("COMPONENT_ID", 190).to_i
    dates = ENV.fetch("DATES", "2022-06-08,2022-06-15,2022-06-22,2022-06-29").split(",").map(&:strip)

    ps = Decidim::Proposals::Proposal.where(decidim_component_id:)
    filename = "decidim_supports_#{decidim_component_id}.csv"

    CSV.open(filename, "wb") do |csv|
      csv << %w(from_date to_date reference title supports_from_impersonated supports_from_verified)
      dates.each do |date|
        from_date = Date.parse(date).beginning_of_day
        to_date = (from_date + 6.days).end_of_day
        ps.each do |p|
          supports = p.votes.where(created_at: from_date..to_date)
          supports_impersonated = supports.select { |s| Decidim::ImpersonationLog.exists?(decidim_user_id: s.decidim_author_id) }.map(&:decidim_author_id).sort.uniq.size
          supports_verified = supports.reject { |s| Decidim::ImpersonationLog.exists?(decidim_user_id: s.decidim_author_id) }.map(&:decidim_author_id).sort.uniq.size

          csv << [date, to_date.strftime("%Y-%m-%d"), p.reference, p.title["ca"] || p.title["es"], supports_impersonated, supports_verified]
        end
      end
    end

    puts "Generated #{filename}"
  end

  desc "Generate CSV summary report with aggregated supports (ENV: COMPONENT_ID, DATES comma-separated)"
  task supports_summary: :environment do
    decidim_component_id = ENV.fetch("COMPONENT_ID", 190).to_i
    dates = ENV.fetch("DATES", "2022-06-08,2022-06-15,2022-06-22,2022-06-29").split(",").map(&:strip)

    ps = Decidim::Proposals::Proposal.where(decidim_component_id:)
    filename = "decidim_supports_#{decidim_component_id}_summary.csv"

    CSV.open(filename, "wb") do |csv|
      csv << %w(from_date to_date supports_from_impersonated supports_from_verified)
      dates.each do |date|
        from_date = Date.parse(date).beginning_of_day
        to_date = (from_date + 6.days).end_of_day
        users = ps.flat_map { |p| p.votes.where(created_at: from_date..to_date).pluck(:decidim_author_id) }.sort.uniq
        supports_impersonated = users.select { |user_id| Decidim::ImpersonationLog.exists?(decidim_user_id: user_id) }.size
        supports_verified = users.reject { |user_id| Decidim::ImpersonationLog.exists?(decidim_user_id: user_id) }.size
        csv << [date, to_date.strftime("%Y-%m-%d"), supports_impersonated, supports_verified]
      end
    end

    puts "Generated #{filename}"
  end
end
