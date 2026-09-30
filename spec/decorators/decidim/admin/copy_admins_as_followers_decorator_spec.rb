# frozen_string_literal: true

require "rails_helper"

RSpec.describe Decidim::Admin::CopyAdminsAsFollowers do
  let(:organization) { create(:organization) }
  let(:copied_slug) { "copied-slug-#{SecureRandom.hex(4)}" }
  let(:invalid) { false }
  let(:form_class) do
    Struct.new(
      :invalid,
      :title,
      :slug,
      :copy_steps,
      :copy_categories,
      :copy_components,
      :copy_landing_page_blocks,
      :current_user,
      keyword_init: true
    ) do
      def invalid?
        invalid
      end

      def copy_steps?
        copy_steps
      end

      def copy_categories?
        copy_categories
      end

      def copy_components?
        copy_components
      end

      def copy_landing_page_blocks?
        copy_landing_page_blocks
      end
    end
  end

  before do
    @admin = create(:user, :admin, :confirmed, organization:)
    @other_admin = create(:user, :admin, :confirmed, organization:)
    @regular_user = create(:user, :confirmed, organization:)
    @admin_from_other_organization = create(:user, :admin, :confirmed)
  end

  attr_reader :admin, :other_admin, :regular_user, :admin_from_other_organization

  def form_for(**kwargs)
    form_class.new(
      invalid:,
      title: { en: "title" },
      slug: copied_slug,
      copy_steps: false,
      copy_categories: false,
      copy_components: false,
      copy_landing_page_blocks: false,
      current_user: admin,
      **kwargs
    )
  end

  context "with participatory processes" do
    subject(:command) { Decidim::ParticipatoryProcesses::Admin::CopyParticipatoryProcess.new(form_for, participatory_process) }

    before do
      @participatory_process = create(:participatory_process, organization:)
    end

    attr_reader :participatory_process

    def copied_process
      Decidim::ParticipatoryProcess.find_by(slug: copied_slug)
    end

    it "makes all the organization admins follow the copy" do
      command.call

      expect(admin.follows?(copied_process)).to be true
      expect(other_admin.follows?(copied_process)).to be true
    end

    it "does not make non-admin users follow the copy" do
      command.call

      expect(regular_user.follows?(copied_process)).to be false
    end

    it "does not make admins from other organizations follow the copy" do
      command.call

      expect(admin_from_other_organization.follows?(copied_process)).to be false
    end

    it "does not change who follows the original process" do
      expect { command.call }.not_to(change { participatory_process.reload.followers.count })
    end

    context "when the form is invalid" do
      let(:invalid) { true }

      it "does not create any copy nor any follow" do
        expect { command.call }.to broadcast(:invalid)

        expect(copied_process).to be_nil
        expect(admin.follows?(participatory_process)).to be false
      end
    end
  end

  context "with assemblies" do
    subject(:command) { Decidim::Assemblies::Admin::CopyAssembly.new(form_for, assembly, admin) }

    before do
      @assembly = create(:assembly, organization:)
    end

    attr_reader :assembly

    def copied_assembly
      Decidim::Assembly.find_by(slug: copied_slug)
    end

    it "makes all the organization admins follow the copy" do
      command.call

      expect(admin.follows?(copied_assembly)).to be true
      expect(other_admin.follows?(copied_assembly)).to be true
    end

    it "does not make non-admin users follow the copy" do
      command.call

      expect(regular_user.follows?(copied_assembly)).to be false
    end

    it "does not make admins from other organizations follow the copy" do
      command.call

      expect(admin_from_other_organization.follows?(copied_assembly)).to be false
    end

    it "does not change who follows the original assembly" do
      expect { command.call }.not_to(change { assembly.reload.followers.count })
    end

    context "when the form is invalid" do
      let(:invalid) { true }

      it "does not create any copy nor any follow" do
        expect { command.call }.to broadcast(:invalid)

        expect(copied_assembly).to be_nil
        expect(admin.follows?(assembly)).to be false
      end
    end
  end
end
