# frozen_string_literal: true

# This migration comes from decidim (originally 20170126151123)
# This file has been modified by `decidim upgrade:migrations` task on 2026-09-01 06:17:35 UTC
class AddExtraInfoToProcesses < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_participatory_processes, :domain, :jsonb
    add_column :decidim_participatory_processes, :end_date, :date
    add_column :decidim_participatory_processes, :developer_group, :string
    add_column :decidim_participatory_processes, :scope, :jsonb
  end
end
