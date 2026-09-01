# frozen_string_literal: true

# This migration comes from decidim (originally 20170914075721)
# This file has been modified by `decidim upgrade:migrations` task on 2026-09-01 06:17:34 UTC
class RemoveFollowableIndexFromFollows < ActiveRecord::Migration[5.1]
  def change
    remove_index :decidim_follows, [:decidim_followable_id, :decidim_followable_type]
  end
end
