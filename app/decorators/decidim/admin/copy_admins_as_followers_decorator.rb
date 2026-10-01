# frozen_string_literal: true

module Decidim
  module Admin
    module CopyAdminsAsFollowersDecorator
      def self.decorate
        [
          Decidim::Assemblies::Admin::CopyAssembly,
          Decidim::ParticipatoryProcesses::Admin::CopyParticipatoryProcess
        ].each do |klass|
          next unless klass

          klass.prepend(
            Module.new do
              include Decidim::Admin::CopyAdminsAsFollowersDecorator

              private

              def copy_assembly(*args, **kwargs, &)
                result = super
                add_admins_as_followers(@copied_assembly)
                result
              end

              def copy_participatory_process(*args, **kwargs, &)
                result = super
                add_admins_as_followers(@copied_process)
                result
              end
            end
          )
        end
      end

      private

      def add_admins_as_followers(space)
        return if space.blank?

        space.organization.admins.each do |admin|
          form = Decidim::FollowForm
                 .from_params(followable_gid: space.to_signed_global_id.to_s)
                 .with_context(
                   current_organization: space.organization,
                   current_user: admin
                 )

          Decidim::CreateFollow.new(form).call
        end
      end
    end
  end
end

Decidim::Admin::CopyAdminsAsFollowersDecorator.decorate
