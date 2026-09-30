# frozen_string_literal: true

require Rails.root.join("app/decorators/decidim/admin/copy_admins_as_followers_decorator")

Rails.application.config.to_prepare do
  Decidim::Admin::CopyAdminsAsFollowers.decorate
end
